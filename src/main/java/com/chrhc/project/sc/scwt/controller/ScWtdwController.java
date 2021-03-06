package com.chrhc.project.sc.scwt.controller;
import com.chrhc.project.sc.scwt.entity.ScWtdwEntity;
import com.chrhc.project.sc.scwt.entity.ScWthdEntity;
import com.chrhc.project.sc.scwt.service.ScWtdwServiceI;
import com.chrhc.project.sc.zhyzh.entity.ScZhyfwzhEntity;
import com.chrhc.project.sc.zhyzh.entity.ScZhyzhfwdEntity;
import com.chrhc.project.sc.zhyzh.entity.ScZhyzhfwjlEntity;

import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.context.annotation.Scope;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;

import java.io.OutputStream;
import org.jeecgframework.core.util.BrowserUtils;
import org.jeecgframework.poi.excel.ExcelExportUtil;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.TemplateExportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.poi.excel.entity.vo.TemplateExcelConstants;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jeecgframework.core.util.ResourceUtil;
import java.io.IOException;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import java.util.Map;
import org.jeecgframework.core.util.ExceptionUtil;



/**   
 * @Title: Controller
 * @Description: 文体队伍表
 * @author onlineGenerator
 * @date 2015-05-09 11:18:51
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/scWtdwController")
public class ScWtdwController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(ScWtdwController.class);

	@Autowired
	private ScWtdwServiceI scWtdwService;
	@Autowired
	private SystemService systemService;
	private String message;
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	/**
	 * 文体队伍表列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "scWtdw")
	public ModelAndView scWtdw(HttpServletRequest request) {
		return new ModelAndView("com/chrhc/project/sc/scwt/scWtdwList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(ScWtdwEntity scWtdw,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(ScWtdwEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, scWtdw, request.getParameterMap());
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.scWtdwService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除文体队伍表
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(ScWtdwEntity scWtdw, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		scWtdw = systemService.getEntity(ScWtdwEntity.class, scWtdw.getId());
		message = "删除成功";
		try{
			//scWtdwService.delete(scWtdw);
			scWtdwService.deleteLogic(scWtdw);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	/**
	 * 判断该文体队伍是否有文体活动记录
	 * @param scZhyzhfwd
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "doCheckWthd")
	@ResponseBody
	public AjaxJson doCheckWthd(ScWtdwEntity scWtdw, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try{
			//判断该文体队伍是否有文体活动
			String hql0 = "from ScWthdEntity where 1 = 1 AND delflag='0' AND teamId = ? ";
			List<ScWthdEntity> scWthdEntityList = systemService.findHql(hql0, scWtdw.getId());	
			//List<ScWthdEntity> scWthdEntityList = (List<ScWthdEntity>) systemService.findByProperty(ScWthdEntity.class,"teamId",scWtdw.getId());
			if(null != scWthdEntityList && scWthdEntityList.size() > 0){
				message = "该文体队伍有文体活动记录，不允许删除";
				j.setSuccess(false);
				j.setMsg(message);
				return j;
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "判断该文体队伍是否有文体活动记录失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	/**
	 * 批量删除文体队伍表
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		message = "删除成功";
		try{
			List<String> list = this.doCheckBatch(ids);
			if(null != list && list.size() > 0){
				message = "文体队伍有文体活动记录，不允许删除";
				j.setSuccess(false);
			}else{
				for(String id:ids.split(",")){
					ScWtdwEntity scWtdw = systemService.getEntity(ScWtdwEntity.class, 
					id
					);
					//scWtdwService.delete(scWtdw);
					scWtdwService.deleteLogic(scWtdw);
					systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
			message = "删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	/**
	 * 批量删除时，判断文体队伍是否是否有文体活动记录
	 * @param ids
	 * @param request
	 * @return
	 */
	private List<String> doCheckBatch(String ids){
		List<String> list = new ArrayList<String>();
		for(String id:ids.split(",")){
			//List<ScWthdEntity> scWthdEntityList = (List<ScWthdEntity>) systemService.findByProperty(ScWthdEntity.class,"teamId",id);
			String hql0 = "from ScWthdEntity where 1 = 1 AND delflag='0' AND teamId = ? ";
			List<ScWthdEntity> scWthdEntityList = systemService.findHql(hql0, id);
			if(null != scWthdEntityList && scWthdEntityList.size() > 0){
				message = "文体队伍有文体活动记录，不允许删除";
				list.add(id);

			}
		}		
		return list;
	}
	/**
	 * 添加文体队伍表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(ScWtdwEntity scWtdw, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "文体队伍表添加成功";
		try{
			scWtdwService.save(scWtdw);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "文体队伍表添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新文体队伍表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(ScWtdwEntity scWtdw, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "文体队伍表更新成功";
		ScWtdwEntity t = scWtdwService.get(ScWtdwEntity.class, scWtdw.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(scWtdw, t);
			scWtdwService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "文体队伍表更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * 文体队伍表新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(ScWtdwEntity scWtdw, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(scWtdw.getId())) {
			scWtdw = scWtdwService.getEntity(ScWtdwEntity.class, scWtdw.getId());
			req.setAttribute("scWtdwPage", scWtdw);
		}
		return new ModelAndView("com/chrhc/project/sc/scwt/scWtdw-add");
	}
	/**
	 * 文体队伍表编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(ScWtdwEntity scWtdw, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(scWtdw.getId())) {
			scWtdw = scWtdwService.getEntity(ScWtdwEntity.class, scWtdw.getId());
			req.setAttribute("scWtdwPage", scWtdw);
		}
		return new ModelAndView("com/chrhc/project/sc/scwt/scWtdw-update");
	}
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		return new ModelAndView("com/chrhc/project/sc/scwt/scWtdwUpload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(ScWtdwEntity scWtdw,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(ScWtdwEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, scWtdw, request.getParameterMap());
		List<ScWtdwEntity> scWtdws = this.scWtdwService.getListByCriteriaQuery(cq,false);
		modelMap.put(NormalExcelConstants.FILE_NAME,"文体队伍表");
		modelMap.put(NormalExcelConstants.CLASS,ScWtdwEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("文体队伍表列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,scWtdws);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(ScWtdwEntity scWtdw,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		modelMap.put(TemplateExcelConstants.FILE_NAME, "文体队伍表");
		modelMap.put(TemplateExcelConstants.PARAMS,new TemplateExportParams("Excel模板地址"));
		modelMap.put(TemplateExcelConstants.MAP_DATA,null);
		modelMap.put(TemplateExcelConstants.CLASS,ScWtdwEntity.class);
		modelMap.put(TemplateExcelConstants.LIST_DATA,null);
		return TemplateExcelConstants.JEECG_TEMPLATE_EXCEL_VIEW;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "importExcel", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			ImportParams params = new ImportParams();
			params.setTitleRows(2);
			params.setHeadRows(1);
			params.setNeedSave(true);
			try {
				List<ScWtdwEntity> listScWtdwEntitys = ExcelImportUtil.importExcelByIs(file.getInputStream(),ScWtdwEntity.class,params);
				for (ScWtdwEntity scWtdw : listScWtdwEntitys) {
					scWtdwService.save(scWtdw);
				}
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(ExceptionUtil.getExceptionMessage(e));
			}finally{
				try {
					file.getInputStream().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return j;
	}
}
