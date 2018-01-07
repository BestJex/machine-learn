package com.ccx.models.service.impl.dataexchange;
import com.ccx.models.Constants;
import com.ccx.models.api.dataexchange.VariableExchangeService;
import com.ccx.models.bean.MsgBean;
import com.ccx.models.bean.RecivePutOutBean;
import com.ccx.models.manager.HttpDataExchangeManager;
import com.ccx.models.mapper.*;
import com.ccx.models.mapper.datafile.ModelsDataFileMapper;
import com.ccx.models.mapper.datafile.ModelsFileIvTopnMapper;
import com.ccx.models.message.MsgPush;
import com.ccx.models.model.*;
import com.ccx.models.model.datafile.ModelsDataFile;
import com.ccx.models.model.datafile.ModelsFileIvTopn;
import com.ccx.models.util.CSVUtil;
import com.ccx.models.util.JsonUtils;
import com.ccx.models.util.StringUtils;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: 数据交换-变量、iv值及重要变量展示
 * @author:lilong
 * @Date: 2017/11/22
 */
@Service
public class VariableExchangeServiceImpl implements VariableExchangeService {

    Logger logger = org.apache.logging.log4j.LogManager.getLogger(this.getClass());

    @Autowired
    private HttpDataExchangeManager httpDataExchangeManager;

    @Autowired
    private ModelsModelDataBaseInfoMapper modelsModelDataBaseInfoMapper;
    @Autowired
    private ModelsVarNumricCountMapper modelsVarNumricCountMapper;
    @Autowired
    private ModelsVarCategoryCountMapper modelsVarCategoryCountMapper;
    @Autowired
    private ModelsImportantCountMapper modelsImportantCountMapper;
    @Autowired
    private ModelsFileIvTopnMapper modelsFileIvTopnMapper;

    @Autowired
    private ModelsVarPathMapper modelsVarPathMapper;

    @Autowired
    private ModelsDataFileMapper modelsDataFileMapper;

    @Autowired
    private MsgPush push;
    /**
     * 发送变量指标统计给模型组（异步请求，请求获取 变量统计指标、iv值及重要性相关数）
     * @param file
     * @return
     */
    @Override
    public Map<String,Object> saveForModelSend(ModelsDataFile file,String userName){
        Map<String,Object> map=new HashMap<>();
        if(file==null) {
            map.put("rsCode","10000");
            map.put("rsMsg","参数有误");
            return  map;
        }
        try{
            //获取http请求数据
            String bean= httpDataExchangeManager.sendMsgToModel(file,userName);
        }catch (Exception e){
            e.printStackTrace();
            throw new RuntimeException("调用模型接口失败",e);
        }

        return map;
    }

    /**
     * 变量异步存储
     * @param putOutBean
     * @param userName
     * @return
     */
    @Override
    public Map<String,Object> saveData(RecivePutOutBean putOutBean, String userName) {
        Map<String,Object> map=new HashMap<>();
        ModelsDataFile file=null;
        try {
            file=modelsDataFileMapper.selectByPrimaryKey(Integer.valueOf(putOutBean.getReqId().split("-")[0]));
            Integer fileId=file.getId();
            //数据概览
            ModelsModelDataBaseInfo dataBaseInfo=putOutBean.getDataDescription().getModelsModelDataBaseInfo(fileId,null,file.getCreatorName());
            //连续性变量
            List<ModelsVarNumricCount> numricList = putOutBean.getDataDescription().getModelsVarNumricCount(fileId.longValue());
            //离散型变量
            List<ModelsVarCategoryCount>  categoryList = putOutBean.getDataDescription().getModelsVarCategoryCount(fileId.longValue());

            //详细变量分析html文件存放路径
            String detailVarPath=(String)putOutBean.getDataDescription().getDetailVarPath().get("path");

            //topN变量与目标变量关系表格路径
            String topNpath=putOutBean.getVariableAnalysis().getTopNpath();
            //d:/data/model/lilong\detailVarIV.csv
            List<ModelsFileIvTopn> topnList =getModelsFileIvTopn(topNpath,fileId);
            //数据存储
            save(fileId,dataBaseInfo,numricList,categoryList,topnList);
            //importantCounts,

            //存储html页面路径
            modelsVarPathMapper.insert(new ModelsVarPath(null,fileId.longValue(),detailVarPath,topNpath));
            map.put("rsCode","0000");
            map.put("rsMsg","成功");
            push.sendMsgToUser(new MsgBean("0000","成功",file), Constants.PUSH_CHANNEL_VAL,(String)MsgPush.comet_map.get(HttpDataExchangeManager.userReqIdMap.get(putOutBean.getReqId())));
        }catch (Exception e){
            logger.error("报错变量信息异常，id为："+file.getId(),e);
            push.sendMsgToUser(new MsgBean("9999","失败",file), Constants.PUSH_CHANNEL_VAL,(String)MsgPush.comet_map.get(HttpDataExchangeManager.userReqIdMap.get(putOutBean.getReqId())));
            throw new RuntimeException("保存出错");
        }
      return map;
    }
   /* @Override
    public Map<String,Object> saveForModelSendTest( RecivePutOutBean putOutBean){
        Map<String,Object> map=new HashMap<>();
        Integer fileId=1;
        try{

            //数据概览
            ModelsModelDataBaseInfo dataBaseInfo=putOutBean.getDataDescription().getModelsModelDataBaseInfo(fileId,null,"test");
            //连续性变量
            List<ModelsVarNumricCount> numricList = putOutBean.getDataDescription().getModelsVarNumricCount(fileId.longValue());
            //离散型变量
            List<ModelsVarCategoryCount>  categoryList = putOutBean.getDataDescription().getModelsVarCategoryCount(fileId.longValue());

            //详细变量分析html文件存放路径
            String detailVarPath=(String)putOutBean.getDataDescription().getDetailVarPath().get("path");

            //重要变量分析
           // List<ModelsImportantCount> importantCounts=putOutBean.getVariableAnalysis().getModelsImportantCount(fileId.longValue());

            //topN变量与目标变量关系表格路径
            String topNpath=putOutBean.getVariableAnalysis().getTopNpath();
            List<ModelsFileIvTopn> topnList =getModelsFileIvTopn(topNpath,fileId);

            //数据存储
            save(fileId, dataBaseInfo, numricList, categoryList, topnList);

            //存储html页面路径
            modelsVarPathMapper.insert(new ModelsVarPath(null,fileId.longValue(),detailVarPath));

            map.put("rsCode","0000");
            map.put("rsMsg","成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("rsCode","9999");
            map.put("rsMsg","系统异常");
        }

        return map;
    }*/
    private void save(final Integer dataFileId, ModelsModelDataBaseInfo dataBaseInfo,
                      List<ModelsVarNumricCount> numricList,
                      List<ModelsVarCategoryCount>  categoryList,
                      //List<ModelsImportantCount> importantCounts,
                      List<ModelsFileIvTopn> topnList){


        new HttpDataExchangeManager.Save<ModelsModelDataBaseInfo, ModelsModelDataBaseInfoMapper>() {
            @Override
            public void insert(ModelsModelDataBaseInfo info, ModelsModelDataBaseInfoMapper mapper) {
                mapper.deleteByDataFileId(info.getDataFileId());
                mapper.insert(info);
            }

        }.insert(dataBaseInfo,modelsModelDataBaseInfoMapper);

        new HttpDataExchangeManager.Save<ModelsVarNumricCount, ModelsVarNumricCountMapper>() {
            @Override
            public void insert(ModelsVarNumricCount info, ModelsVarNumricCountMapper mapper) {
                mapper.insert(info);
            }

            @Override
            public void delete(Integer fileId, ModelsVarNumricCountMapper mapper) {
                mapper.deleteByDataFileId(fileId);
            }
        }.insertBatch(numricList,modelsVarNumricCountMapper,dataFileId);


        new HttpDataExchangeManager.Save<ModelsVarCategoryCount, ModelsVarCategoryCountMapper>() {
            @Override
            public void insert(ModelsVarCategoryCount info, ModelsVarCategoryCountMapper mapper) {
                mapper.insert(info);
            }

            @Override
            public void delete(Integer fileId, ModelsVarCategoryCountMapper mapper) {
                mapper.deleteByDataFileId(fileId);
            }
        }.insertBatch(categoryList,modelsVarCategoryCountMapper,dataFileId);

      /*  new HttpDataExchangeManager.Save<ModelsImportantCount, ModelsImportantCountMapper>() {
            @Override
            public void insert(ModelsImportantCount info, ModelsImportantCountMapper mapper) {
                mapper.insert(info);
            }

            @Override
            public void delete(Integer fileId, ModelsImportantCountMapper mapper) {
                mapper.deleteByDataFileId(fileId);
            }
        }.insertBatch(importantCounts,modelsImportantCountMapper,dataFileId);
        }.insertBatch(importantCounts,modelsImportantCountMapper);*/

        new HttpDataExchangeManager.Save<ModelsFileIvTopn, ModelsFileIvTopnMapper>() {
            @Override
            public void insert(ModelsFileIvTopn info, ModelsFileIvTopnMapper mapper) {
                mapper.insert(info);
            }

            @Override
            public void delete(Integer fileId, ModelsFileIvTopnMapper mapper) {
                mapper.deleteByDataFileId(fileId);
            }
        }.insertBatch(topnList,modelsFileIvTopnMapper,dataFileId);

    }

    //topN变量与目标变量关系
    private static List<ModelsFileIvTopn> getModelsFileIvTopn(String path, Integer fileId) {
        List<String[]> list = CSVUtil.read(path);
        List<ModelsFileIvTopn> li = new ArrayList<>();
        for (int i = 1; i < list.size(); i++) {
        /*    li.add(new ModelsFileIvTopn(null,fileId.longValue(),list.get(i)[5],list.get(i)[0],
                    list.get(i)[1]==null?null:Integer.valueOf(list.get(i)[1]),
                    list.get(i)[2]==null?null:Integer.valueOf(list.get(i)[2]),
                    list.get(i)[3]==null?null:Integer.valueOf(list.get(i)[3]),
                    list.get(i)[4]==null?null:(list.get(i)[4].contains("%")?
                            new BigDecimal(list.get(i)[4].replace("%",""))
                            :new BigDecimal(list.get(i)[4]))));*/
            li.add(new ModelsFileIvTopn(null, fileId.longValue(), list.get(i)[10], list.get(i)[0],
                    StringUtils.isEmpty(list.get(i)[1])? null : Integer.valueOf(list.get(i)[1]),
                    StringUtils.isEmpty(list.get(i)[2] ) ? null : Integer.valueOf(list.get(i)[2]),
                    StringUtils.isEmpty( list.get(i)[3]) ? null : Integer.valueOf(list.get(i)[3]),
                    StringUtils.isEmpty(list.get(i)[4]) ? null : new BigDecimal(list.get(i)[4]),
                    StringUtils.isEmpty(list.get(i)[5]) ? null : new BigDecimal(list.get(i)[5]),
                    StringUtils.isEmpty(list.get(i)[6]) ? null : new BigDecimal(list.get(i)[6]),
                    StringUtils.isEmpty(list.get(i)[7]) ? null : new BigDecimal(list.get(i)[7]),
                    list.get(i)[8],
                    StringUtils.isEmpty( list.get(i)[9] ) ? null : new BigDecimal(list.get(i)[9]),
                    list.get(i)[11]));
    }
        return li;
    }

    public static void main(String[] args) {
        getModelsFileIvTopn("D:/dlcache/detailVarIV_2017-12-11_150933.csv",2);
    }
}
