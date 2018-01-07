package com.ccx.models.mapper;

import com.ccx.models.model.ModelsImportantCount;

public interface ModelsImportantCountMapper extends BaseMapper<ModelsImportantCount>{
    int deleteByPrimaryKey(Integer id);

    /**
     * 通过数据文件删除
     */
    int deleteByDataFileId(Integer dataFileId);

    int insert(ModelsImportantCount record);

    int insertSelective(ModelsImportantCount record);

    ModelsImportantCount selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ModelsImportantCount record);

    int updateByPrimaryKey(ModelsImportantCount record);
}