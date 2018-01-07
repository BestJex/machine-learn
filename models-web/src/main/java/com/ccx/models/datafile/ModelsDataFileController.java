package com.ccx.models.datafile;

import com.alibaba.fastjson.JSON;
import com.ccx.models.api.ModelsModelDataBaseInfoService;
import com.ccx.models.api.ModelsVarCategoryCountService;
import com.ccx.models.api.ModelsVarNumricCountService;
import com.ccx.models.api.dataexchange.VariableExchangeService;
import com.ccx.models.api.datafile.ModelsDataFileApi;
import com.ccx.models.api.datafile.ModelsFileInfoApi;
import com.ccx.models.api.datafile.ModelsFileIvTopnApi;
import com.ccx.models.base.BasicController;
import com.ccx.models.mapper.ModelsVarPathMapper;
import com.ccx.models.model.ModelsModelDataBaseInfo;
import com.ccx.models.model.ModelsVarCategoryCount;
import com.ccx.models.model.ModelsVarNumricCount;
import com.ccx.models.model.User;
import com.ccx.models.model.datafile.ModelsDataFile;
import com.ccx.models.model.datafile.ModelsFileInfo;
import com.ccx.models.model.datafile.ModelsFileIvTopn;
import com.ccx.models.service.impl.datafile.CommonFileValue;
import com.ccx.models.service.impl.datafile.CommonGetFileValue;
import com.ccx.models.util.*;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description 数据文件
 * @author xzd
 * @date 2017/11/21
 */
@Controller	
@RequestMapping("/modelsDataFile")
public class ModelsDataFileController extends BasicController{
	private static final Logger logger = LoggerFactory.getLogger(ModelsDataFileController.class);
		
	@Autowired	
	private ModelsDataFileApi modelsDataFileApi;

	@Autowired
	private ModelsFileInfoApi modelsFileInfoApi;

	//获取文件数据的公共方法
	@Autowired
	private CommonGetFileValue commonGetFileValue;

	@Autowired
	private ModelsModelDataBaseInfoService dataBaseInfoService;

	@Autowired
	private ModelsVarNumricCountService varNumricCountService;

	@Autowired
	private ModelsVarCategoryCountService varCategoryCountService;

	@Autowired
	private ModelsFileInfoApi modelsFileInfoService;

	@Autowired
	private ModelsFileIvTopnApi modelsFileIvTopnApi;

	@Autowired
	private VariableExchangeService variableExchangeService;

	@Autowired
	private ModelsVarPathMapper modelsVarPathMapper;

	/**
	 * 数据文件列表展示
	 * @param request
	 * @return
	 */
	@GetMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("datafile/dataFileList");
	}

	/**
	 * 查询数据文件列表
	 * @return
	 */
	@PostMapping("/findAll")
	@ResponseBody
	public JsonResult findAll(HttpServletRequest request){
		//获取查询条件
		Map<String, Object> params = ControllerUtil.requestMap(request);

		//分页
		PageInfo<ModelsDataFile> pages = new PageInfo<>();
		PageHelper.startPage(getPageNum(), getPageSize());

		//角色
		String roleType = ControllerUtil.getRoleType();
		params.put("roleType",roleType);

		try {
			pages = modelsDataFileApi.getPageList(params);

			//成功标识
			return JsonResult.ok(pages);
		} catch (Exception e) {
			logger.error("查询数据文件失败:", e);
			//失败标识
			return JsonResult.error("查询数据文件失败！");
		}
	}

	/**
	 * 校验文件名称唯一
	 * @param name
	 * @return
	 */
	@PostMapping("/validateName")
	@ResponseBody
	public JsonResult validateName(@RequestParam(required = true) String name){
		//当前name在数据库中是否存在
		int count = modelsDataFileApi.validateName(name);

		return (count <= 0) ? JsonResult.ok(null) : JsonResult.error("文件名称已存在，请重新添加！");
	}

	/**
	 * 数据文件导入页面
	 * @param request
	 * @return
	 */
	@GetMapping("/importDataFile")
	public ModelAndView importDataFile(HttpServletRequest request) {
		return new ModelAndView("datafile/dataFileImport");
	}

	/**
	 * 数据文件导入
	 * @param request
	 * @return
	 */
	@PostMapping("/doImportDataFile")
	@ResponseBody
	public String doImportDataFile(HttpServletRequest request, HttpServletResponse response, @RequestParam("dataFile") MultipartFile dataFile) {
		//result jsp map
		Map<String, Object> resultMap = new HashMap<>();
		//获取参数
		Map<String, Object> params = ControllerUtil.requestMap(request);
		//当前用户
		User currentUser = ControllerUtil.getSessionUser(request);
		//当前用户名称
		params.put("currentUserName", currentUser.getLoginName());

		if (dataFile == null || dataFile.isEmpty()) {
			resultMap.put("code", 401);
			logger.error("上传文件报错，错误原因============>没有上传文件");
			return JSON.toJSONString(resultMap);
		}

		try {
			modelsDataFileApi.save(dataFile, params);
			resultMap.put("code", 200);
		} catch (Exception e) {
			if (e instanceof MyRuntimeException) {
				resultMap.put("code", 401);
				//deal return msg
				String msg = e.getMessage();
				if (msg.contains("::")) {
					String[] msgArr = msg.split("::");
					resultMap.put("msg", msgArr[0]);
				}
			} else {
				resultMap.put("code", 500);
			}
			logger.error("文件导入失败！", e);
		}

		return JSON.toJSONString(resultMap);
	}

	/**
	 * 文件详情
	 * @param request
	 * @return
	 */
	@GetMapping("/fileInfo")
	public ModelAndView fileInfo(HttpServletRequest request,
				 @RequestParam(required = true) Integer id, @RequestParam(required = true) Integer isUpdate) {
		//数据文件id
		request.setAttribute("dataFileId", id);
		//是否更新标识
		request.setAttribute("isUpdate", isUpdate);

		return new ModelAndView("datafile/fileInfo");
	}

	/**
	 * 查询数据文件详情和文件变量以及变量值
	 * @return
	 */
	@PostMapping("/findFileInfo")
	@ResponseBody
	public JsonResult findFileInfo(HttpServletRequest request,
			   @RequestParam(required = true) Integer dataFileId, @RequestParam(required = true) Integer isUpdate){
		try {
			//是否更新标识
			boolean flag = isUpdate == 0 ? false : true;

			//通过数据文件id获取文件信息
			CommonFileValue.DataFile dataFile = commonGetFileValue.getCommonDataFile(dataFileId, flag);

			//成功标识
			return JsonResult.ok(dataFile);
		} catch (Exception e) {
			logger.error("查询数据文件信息失败:", e);
			//失败标识
			return JsonResult.error("查询数据文件信息失败！");
		}
	}

	/**
	 * 数据标记
	 * @param request
	 * @return
	 */
	@GetMapping("/dataMark")
	public ModelAndView dataMark(HttpServletRequest request, @RequestParam(required = true) Integer id) {
		//数据文件id
		request.setAttribute("dataFileId", id);

		return new ModelAndView("datafile/dataMark");
	}

	/**
	 * 查询数据文件详情和文件变量
	 * @return
	 */
	@PostMapping("/findDataMark")
	@ResponseBody
	public JsonResult findDataMark(HttpServletRequest request, @RequestParam(required = true) Integer dataFileId){
		try {
			//文件信息
			ModelsDataFile dataFile = modelsDataFileApi.getById(dataFileId);

			//变量信息
			List<ModelsFileInfo> fileInfoList = modelsFileInfoApi.selectByFileId(dataFileId);

			//通过数据文件id获取文件信息
			CommonFileValue.DataFile dataFileList = commonGetFileValue.getCommonDataFile(dataFileId, false);

			Map<String, Object> dataMap = new HashMap();

			dataMap.put("dataFile", dataFile);
			dataMap.put("fileInfoList", fileInfoList);
			dataMap.put("dataFileList", dataFileList);

			//成功标识
			return JsonResult.ok(dataMap);
		} catch (Exception e) {
			logger.error("查询数据文件信息和文件变量失败:", e);
			//失败标识
			return JsonResult.error("查询数据文件信息和文件变量失败！");
		}
	}

	/**
	 * 保存变量类型修改
	 * @param request
	 * @param inputIds 变量id
	 * @param columnTypes 变量类型
	 * @return
	 */
	@PostMapping("/saveDataMark")
	@ResponseBody
	public JsonResult saveDataMark(HttpServletRequest request, @RequestParam(required = true) Integer dataFileId,
			@RequestParam(required = true) String inputIds, @RequestParam(required = true) String columnTypes){
		String[] ids = inputIds.split(",");
		String[] types = columnTypes.split(",");

		try {
			for (int i = 0; i < ids.length; i++) {
				//type not null
				if (!StringUtils.isEmpty(types[i])) {
					ModelsFileInfo fileInfo = new ModelsFileInfo();

					fileInfo.setId(Integer.valueOf(ids[i]));
					fileInfo.setType(Integer.valueOf(types[i]));

					modelsFileInfoApi.updateTypeById(fileInfo);
				}
			}

			final ModelsDataFile modelsDataFile = modelsDataFileApi.getById(dataFileId);

			//调用模型变量统计
			new Thread(() ->{
				variableExchangeService.saveForModelSend(modelsDataFile,((User) request.getSession().getAttribute("risk_crm_user")).getLoginName());
			}).start();
			//成功标识
			return JsonResult.ok(null);
		} catch (Exception e) {
			logger.error("保存变量类型修改失败:", e);
			//失败标识
			return JsonResult.error("保存变量类型修改失败！");
		}
	}

	/**
	 * 删除文件信息
	 * @param request
	 * @return
	 */
	@PostMapping("/delete")
	@ResponseBody
	public JsonResult delete(HttpServletRequest request, @RequestParam(required = true) Integer dataFileId) {
		try {
			//逻辑删除
			modelsDataFileApi.deleteById(dataFileId);

			//成功标识
			return JsonResult.ok(null);
		} catch (Exception e) {
			logger.error("删除数据文件失败:", e);
			//失败标识
			return JsonResult.error("删除数据文件失败！");
		}
	}

	/**
	 * 变量分析
	 */
	@GetMapping("/varAnalysis")
	public ModelAndView varAnalysis(Integer dataFileId) {
		ModelAndView mnv = new ModelAndView("datafile/fileAnalysis");

		try {
			Long id = Long.valueOf(dataFileId.toString());
			ModelsVarNumricCount modelsVarNumricCount = new ModelsVarNumricCount();
			ModelsVarCategoryCount modelsVarCategoryCount = new ModelsVarCategoryCount();
			modelsVarNumricCount.setDataFileId(id);
			modelsVarCategoryCount.setDataFileId(id);

			ModelsModelDataBaseInfo dataBaseInfo = dataBaseInfoService.getByJoinDataFile(id);
			List<ModelsVarNumricCount> varNumricCountList = varNumricCountService.getList(modelsVarNumricCount);
			List<ModelsVarCategoryCount> varCategoryCountList = varCategoryCountService.getList(modelsVarCategoryCount);
			List<ModelsFileInfo> infoList = modelsFileInfoService.getVarListByFileId(dataFileId);

			mnv.addObject("dataFileId", dataFileId);
			mnv.addObject("dataBaseInfo", dataBaseInfo);
			mnv.addObject("varNumricCountList", varNumricCountList);
			mnv.addObject("varCategoryCountList", varCategoryCountList);
			mnv.addObject("varList", infoList);
		} catch (Exception e) {
			logger.error("变量分析失败：", e);
		}
		return mnv;
	}

	@GetMapping("/downloadHtml")
	public void downloadHtml(HttpServletResponse response, @RequestParam(required = true) Integer dataFileId) {
		try {
			//html url
			String htmlUrl = modelsVarPathMapper.selectHtmlUrlByDataFileId(dataFileId);

			if (htmlUrl != null) {
				//文件名称
				String fileName = htmlUrl.substring(htmlUrl.lastIndexOf("/")+1);
				//调用共用的下载方法
				DownloadUtil.download(htmlUrl, fileName, response);
			} else {
				throw new RuntimeException("下载html文件报错：文件路径为空");
			}
		} catch (Exception e) {
			logger.error("下载html失败:", e);
		}
	}

	@GetMapping("/downloadIV")
	public void downloadIV(HttpServletResponse response, @RequestParam(required = true) Integer dataFileId) {
		try {
			//html url
			String ivUrl = modelsVarPathMapper.selectIVUrlByDataFileId(dataFileId);

			if (ivUrl != null) {
				//文件名称
				String fileName = ivUrl.substring(ivUrl.lastIndexOf("/")+1);
				//调用共用的下载方法
				DownloadUtil.download(ivUrl, fileName, response);
			}
		} catch (Exception e) {
			logger.error("下载iv失败:", e);
		}
	}

	@PostMapping("/varIvList")
	@ResponseBody
	public JsonResult varIvList(@RequestParam(required = true) Integer dataFileId, String varName) {
		try {
			if (StringUtils.isNotBlank(varName)) {
				List<ModelsFileIvTopn> ivList = modelsFileIvTopnApi.getIvListByFileIdAndVarName(dataFileId, varName);
				return JsonResult.ok(ivList);
			} else {
				return JsonResult.ok(new ArrayList<>());
			}

		} catch (Exception e) {
			logger.error("IV分析显示列表:", e);
			return JsonResult.error(null);
		}
	}
}
