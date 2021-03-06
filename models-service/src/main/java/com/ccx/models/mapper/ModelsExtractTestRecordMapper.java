package com.ccx.models.mapper;

import java.util.Map;

import com.ccx.models.model.ModelsExtractTestRecord;

public interface ModelsExtractTestRecordMapper {
    int deleteByPrimaryKey(Long id);

    int insert(ModelsExtractTestRecord record);

    int insertSelective(ModelsExtractTestRecord record);

    ModelsExtractTestRecord selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(ModelsExtractTestRecord record);

    int updateByPrimaryKeyWithBLOBs(ModelsExtractTestRecord record);

    int updateByPrimaryKey(ModelsExtractTestRecord record);
    
    Map<String, Object> selectIndexName(Long modelRecordId);
}