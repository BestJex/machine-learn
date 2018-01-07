package com.ccx.models.api.datafile;
	
import com.ccx.models.model.datafile.ModelsFileInfo;
import com.ccx.models.model.datafile.ModelsFileIvTopn;
import com.ccx.models.util.Page;

import java.util.*;
	
public interface ModelsFileInfoApi {
		
	//主键获取	
	ModelsFileInfo getById(Integer id);
		
	//获取无参list	
	List<ModelsFileInfo> getList();	
		
	//获取有参数list	
	List<ModelsFileInfo> getList(ModelsFileInfo model);	
		
	//获取带分页list	
	List<ModelsFileInfo> getPageList(Page<ModelsFileInfo> page);
		
	//通过条件获取	
	ModelsFileInfo getByModel(ModelsFileInfo model);	
	
	//保存对象	
	int save(ModelsFileInfo model);

	//更新对象
	int update(ModelsFileInfo model);

	//修改变量类型：离散/连续
	int updateTypeById(ModelsFileInfo modelsFileInfo);
		
	//删除对象	
	int deleteById(Integer id);	
		
	//其他查询	
	Map<String, Object> getOther();

    List<ModelsFileInfo> selectByFileId(Integer fileId);

    List<ModelsFileInfo> getVarListByFileId(Integer dataFileId);
}
