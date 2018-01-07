package com.ccx.models.api;
	
import com.ccx.models.model.ModelsArithmetic;
import com.ccx.models.model.ModelsProgram;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;

import java.util.*;
	
public interface ModelsProgramApi {
		
	//主键获取	
	ModelsProgram getById(Integer id);	
		
	//获取无参list	
	List<ModelsProgram> getList();	
		
	//获取有参数list	
	List<ModelsProgram> getList(ModelsProgram model);	
		
	//获取带分页list	
	PageInfo<ModelsProgram> getPageList(Map<String, Object> params);

	List<ModelsProgram> getList(Map<String, Object> params);

	//通过条件获取	
	ModelsProgram getByModel(ModelsProgram model);

	/**
	 * @Description: 根据项目名称查询数据库中的已存在的项目条数
	 * @Author: wxn
	 * @Date: 2017/12/5 18:04:02
	 * @Param:
	 * @Return
	 */
	List<ModelsProgram> getListByName(String name);
	
	//保存对象	
	int save(ModelsProgram model);
	
	//更新对象	
	int update(ModelsProgram model);	
		
	//删除对象	
	int deleteById(Integer id);	
		
	//其他查询	
	Map<String, Object> getOther();

    List<ModelsArithmetic> selectArithmeticList();
}	
