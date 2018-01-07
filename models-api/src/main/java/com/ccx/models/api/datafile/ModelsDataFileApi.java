package com.ccx.models.api.datafile;
	
import com.ccx.models.model.datafile.ModelsDataFile;
import com.ccx.models.util.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
	
public interface ModelsDataFileApi {
		
	//主键获取	
	ModelsDataFile getById(Integer id);

	//校验文件名称唯一性
	int validateName(String name);
		
	//获取有参数list
	List<ModelsDataFile> getList(Map<String, Object> params);
		
	//获取无参list
	List<ModelsDataFile> getList();
		
	//获取带分页list	
	PageInfo<ModelsDataFile> getPageList(Map<String, Object> paramMap);
		
	//通过条件获取	
	ModelsDataFile getByModel(ModelsDataFile model);	
	
	//保存对象	
	void save(MultipartFile dataFile, Map<String, Object> params);
	
	//更新对象	
	int update(ModelsDataFile model);	
		
	//删除对象	
	int deleteById(Integer id);	
		
	//其他查询	
	Map<String, Object> getOther();
}	
