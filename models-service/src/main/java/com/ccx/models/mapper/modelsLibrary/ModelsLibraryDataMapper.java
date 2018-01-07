package com.ccx.models.mapper.modelsLibrary;

import java.util.List;

import com.ccx.models.model.ModelsExtractImportRowValue;
import com.ccx.models.model.ModelsExtractTestRecord;
import com.ccx.models.model.SectionCount;

public interface ModelsLibraryDataMapper {


	/**
	 * 模型测试结果列表
	 * @return
	 */
	public List<SectionCount> modelTextResult(String id);
	
	/**
	 * 模型库-统计区间
	 * @return
	 */
	public SectionCount modelTextCount(String id);

	/**
	 * 模型测试记录入库
	 * @param bean
	 * @return
	 */
	int saveModelExtractTest(ModelsExtractTestRecord bean);
	
	/**
	 * 批量存储文件信息
	 * @param bean
	 * @return
	 */
	int saveBatchModelTest(List<ModelsExtractImportRowValue> list);
}