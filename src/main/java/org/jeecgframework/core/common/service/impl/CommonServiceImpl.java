package org.jeecgframework.core.common.service.impl;

import java.io.FileNotFoundException;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.system.pojo.base.TSDepart;

import org.apache.commons.beanutils.PropertyUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.jeecgframework.core.common.dao.ICommonDao;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.hibernate.qbc.HqlQuery;
import org.jeecgframework.core.common.hibernate.qbc.PageList;
import org.jeecgframework.core.common.model.common.DBTable;
import org.jeecgframework.core.common.model.common.UploadFile;
import org.jeecgframework.core.common.model.json.ComboTree;
import org.jeecgframework.core.common.model.json.DataGridReturn;
import org.jeecgframework.core.common.model.json.ImportFile;
import org.jeecgframework.core.common.model.json.TreeGrid;
import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.tag.vo.datatable.DataTableReturn;
import org.jeecgframework.tag.vo.easyui.Autocomplete;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.tag.vo.easyui.TreeGridModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chrhc.Interceptor.InterceptorException;

@Service("commonService")
@Transactional
public class CommonServiceImpl implements CommonService {
	public ICommonDao commonDao = null;

	/**
	 * 获取所有数据库表
	 * 
	 * @return
	 */
	public List<DBTable> getAllDbTableName() {
		return commonDao.getAllDbTableName();
	}

	public Integer getAllDbTableSize() {
		return commonDao.getAllDbTableSize();
	}

	@Resource
	public void setCommonDao(ICommonDao commonDao) {
		this.commonDao = commonDao;
	}

	
	public <T> Serializable save(T entity) {
		entity = beforeSave(entity);
		return commonDao.save(entity);
	}

	
	public <T> void saveOrUpdate(T entity) {
		entity = beforeSave(entity);
		commonDao.saveOrUpdate(entity);

	}

	
	public <T> void delete(T entity) {
		commonDao.delete(entity);

	}

	/**
	 * 删除实体集合
	 * 
	 * @param <T>
	 * @param entities
	 */
	public <T> void deleteAllEntitie(Collection<T> entities) {
		commonDao.deleteAllEntitie(entities);
	}

	/**
	 * 根据实体名获取对象
	 */
	public <T> T get(Class<T> class1, Serializable id) {
		return commonDao.get(class1, id);
	}

	/**
	 * 根据实体名返回全部对象
	 * 
	 * @param <T>
	 * @param hql
	 * @param size
	 * @return
	 */
	public <T> List<T> getList(Class clas) {
		return commonDao.loadAll(clas);
	}

	/**
	 * 根据实体名获取对象
	 */
	public <T> T getEntity(Class entityName, Serializable id) {
		return commonDao.getEntity(entityName, id);
	}

	/**
	 * 根据实体名称和字段名称和字段值获取唯一记录
	 * 
	 * @param <T>
	 * @param entityClass
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public <T> T findUniqueByProperty(Class<T> entityClass,
			String propertyName, Object value) {
		return commonDao.findUniqueByProperty(entityClass, propertyName, value);
	}

	/**
	 * 按属性查找对象列表.
	 */
	public <T> List<T> findByProperty(Class<T> entityClass,
			String propertyName, Object value) {

		return commonDao.findByProperty(entityClass, propertyName, value);
	}

	/**
	 * 加载全部实体
	 * 
	 * @param <T>
	 * @param entityClass
	 * @return
	 */
	public <T> List<T> loadAll(final Class<T> entityClass) {
		return commonDao.loadAll(entityClass);
	}

	public <T> T singleResult(String hql) {
		return commonDao.singleResult(hql);
	}

	/**
	 * 删除实体主键ID删除对象
	 * 
	 * @param <T>
	 * @param entities
	 */
	public <T> void deleteEntityById(Class entityName, Serializable id) {
		commonDao.deleteEntityById(entityName, id);
	}

	/**
	 * 更新指定的实体
	 * 
	 * @param <T>
	 * @param pojo
	 */
	public <T> void updateEntitie(T pojo) {
		commonDao.updateEntitie(pojo);

	}

	/**
	 * 通过hql 查询语句查找对象
	 * 
	 * @param <T>
	 * @param query
	 * @return
	 */
	public <T> List<T> findByQueryString(String hql) {
		return commonDao.findByQueryString(hql);
	}

	/**
	 * 根据sql更新
	 * 
	 * @param query
	 * @return
	 */
	public int updateBySqlString(String sql) {
		return commonDao.updateBySqlString(sql);
	}

	/**
	 * 根据sql查找List
	 * 
	 * @param <T>
	 * @param query
	 * @return
	 */
	public <T> List<T> findListbySql(String query) {
		return commonDao.findListbySql(query);
	}

	/**
	 * 通过属性称获取实体带排序
	 * 
	 * @param <T>
	 * @param clas
	 * @return
	 */
	public <T> List<T> findByPropertyisOrder(Class<T> entityClass,
			String propertyName, Object value, boolean isAsc) {
		return commonDao.findByPropertyisOrder(entityClass, propertyName,
				value, isAsc);
	}

	/**
	 * 
	 * cq方式分页
	 * 
	 * @param cq
	 * @param isOffset
	 * @return
	 */
	public PageList getPageList(final CriteriaQuery cq, final boolean isOffset) {
		return commonDao.getPageList(cq, isOffset);
	}

	/**
	 * 返回DataTableReturn模型
	 * 
	 * @param cq
	 * @param isOffset
	 * @return
	 */
	public DataTableReturn getDataTableReturn(final CriteriaQuery cq,
			final boolean isOffset) {
		return commonDao.getDataTableReturn(cq, isOffset);
	}

	/**
	 * 返回easyui datagrid模型
	 * 
	 * @param cq
	 * @param isOffset
	 * @return
	 */
	public DataGridReturn getDataGridReturn(final CriteriaQuery cq,
			final boolean isOffset) {
		return commonDao.getDataGridReturn(cq, isOffset);
	}

	/**
	 * 
	 * hqlQuery方式分页
	 * 
	 * @param cq
	 * @param isOffset
	 * @return
	 */
	public PageList getPageList(final HqlQuery hqlQuery,
			final boolean needParameter) {
		return commonDao.getPageList(hqlQuery, needParameter);
	}

	/**
	 * 
	 * sqlQuery方式分页
	 * 
	 * @param cq
	 * @param isOffset
	 * @return
	 */
	public PageList getPageListBySql(final HqlQuery hqlQuery,
			final boolean isToEntity) {
		return commonDao.getPageListBySql(hqlQuery, isToEntity);
	}

	public Session getSession()

	{
		return commonDao.getSession();
	}

	public List findByExample(final String entityName,
			final Object exampleEntity) {
		return commonDao.findByExample(entityName, exampleEntity);
	}

	/**
	 * 通过cq获取全部实体
	 * 
	 * @param <T>
	 * @param cq
	 * @return
	 */
	public <T> List<T> getListByCriteriaQuery(final CriteriaQuery cq,
			Boolean ispage) {
		return commonDao.getListByCriteriaQuery(cq, ispage);
	}

	/**
	 * 文件上传
	 * 
	 * @param request
	 */
	public <T> T uploadFile(UploadFile uploadFile) {
		return commonDao.uploadFile(uploadFile);
	}

	public <T> T uploadFileLocal(UploadFile uploadFile) {
		return commonDao.uploadFileLocal(uploadFile);
	}
	public HttpServletResponse viewOrDownloadFile(UploadFile uploadFile)

	{
		return commonDao.viewOrDownloadFile(uploadFile);
	}

	/**
	 * 生成XML文件
	 * 
	 * @param fileName
	 *            XML全路径
	 * @return
	 */
	public HttpServletResponse createXml(ImportFile importFile) {
		return commonDao.createXml(importFile);
	}

	/**
	 * 解析XML文件
	 * 
	 * @param fileName
	 *            XML全路径
	 */
	public void parserXml(String fileName) {
		commonDao.parserXml(fileName);
	}

	public List<ComboTree> comTree(List<TSDepart> all, ComboTree comboTree) {
		return commonDao.comTree(all, comboTree);
	}

	public List<ComboTree> ComboTree(List all, ComboTreeModel comboTreeModel, List in, boolean recursive) {
        return commonDao.ComboTree(all, comboTreeModel, in, recursive);
	}

	/**
	 * 构建树形数据表
	 */
	public List<TreeGrid> treegrid(List all, TreeGridModel treeGridModel) {
		return commonDao.treegrid(all, treeGridModel);
	}

	/**
	 * 获取自动完成列表
	 * 
	 * @param <T>
	 * @return
	 */
	public <T> List<T> getAutoList(Autocomplete autocomplete) {
		StringBuffer sb = new StringBuffer("");
		for (String searchField : autocomplete.getSearchField().split(",")) {
			sb.append("  or " + searchField + " like '%"
					+ autocomplete.getTrem() + "%' ");
		}
		String hql = "from " + autocomplete.getEntityName() + " where 1!=1 "
				+ sb.toString();
		return commonDao.getSession().createQuery(hql)
				.setFirstResult(autocomplete.getCurPage() - 1)
				.setMaxResults(autocomplete.getMaxRows()).list();
	}

	
	public Integer executeSql(String sql, List<Object> param) {
		return commonDao.executeSql(sql, param);
	}

	
	public Integer executeSql(String sql, Object... param) {
		return commonDao.executeSql(sql, param);
	}

	
	public Integer executeSql(String sql, Map<String, Object> param) {
		return commonDao.executeSql(sql, param);
	}
	
	public Object executeSqlReturnKey(String sql, Map<String, Object> param) {
		 commonDao.executeSql(sql, param);
		return param.get("id");
	}
	
	public List<Map<String, Object>> findForJdbc(String sql, int page, int rows) {
		return commonDao.findForJdbc(sql, page, rows);
	}

	
	public List<Map<String, Object>> findForJdbc(String sql, Object... objs) {
		return commonDao.findForJdbc(sql, objs);
	}

	
	public List<Map<String, Object>> findForJdbcParam(String sql, int page,
			int rows, Object... objs) {
		return commonDao.findForJdbcParam(sql, page, rows, objs);
	}

	
	public <T> List<T> findObjForJdbc(String sql, int page, int rows,
			Class<T> clazz) {
		return commonDao.findObjForJdbc(sql, page, rows, clazz);
	}

	
	public Map<String, Object> findOneForJdbc(String sql, Object... objs) {
		return commonDao.findOneForJdbc(sql, objs);
	}

	
	public Long getCountForJdbc(String sql) {
		return commonDao.getCountForJdbc(sql);
	}

    //update-begin--Author:JueYue  Date:20140514 for：调用方法错误--------------------
	public Long getCountForJdbcParam(String sql, Object[] objs) {
		return commonDao.getCountForJdbcParam(sql,objs);
	}
    //update-end--Author:JueYue  Date:20140514 for：调用方法错误--------------------

	
	public <T> void batchSave(List<T> entitys) {
		this.commonDao.batchSave(entitys);
	}

	/**
	 * 通过hql 查询语句查找对象
	 * 
	 * @param <T>
	 * @param query
	 * @return
	 */
	public <T> List<T> findHql(String hql, Object... param) {
		return this.commonDao.findHql(hql, param);
	}

	public <T> List<T> pageList(DetachedCriteria dc, int firstResult,
			int maxResult) {
		return this.commonDao.pageList(dc, firstResult, maxResult);
	}

	public <T> List<T> findByDetached(DetachedCriteria dc) {
		return this.commonDao.findByDetached(dc);
	}

	/**
	 * 下载文件：From FTP To Server
	 * @param svRealPath
	 * @param svRealPath2
	 * @param svRealPath3
	 * @return
	 * @throws FileNotFoundException
	 */
	public String downFTPToSV(String svRealPath, String directory, String fileName) throws FileNotFoundException{
		return this.commonDao.downFTPToSV(svRealPath, directory, fileName);
	}

	/**
	 * 下载文件：From FTP To Server
	 * @param uploadFile
	 * @return
	 * @throws FileNotFoundException
	 */
	public String downFTPToSV(UploadFile uploadFile) throws FileNotFoundException{
		return this.commonDao.downFTPToSV(uploadFile);
	}

	/**
	 * 
	 * @param directory
	 * @param fileName
	 * @param response
	 * @throws FileNotFoundException
	 */
	public void downFTPToJsp(String directory, String fileName,
			HttpServletResponse response){
		this.commonDao.downFTPToJsp(directory, fileName, response);
	}
	/**
	 * 执行保存更新之前，比对数据版本是否相同
	 * @param entity
	 * @return
	 * @throws InterceptorException
	 */
	public <T> T beforeSave(T entity) throws InterceptorException {

		Class objClass = entity.getClass();
		String objType = objClass.getSimpleName();

		Integer versionNum = 0;//实体类的version_num
		String id = "";//实体类的id
		Integer numDb = 0;//数据库中，该条数据的version_num
		try {
			Method m1 = (Method) objClass.getMethod("getVersionNum");
			if(m1 == null){
				//没有版本字段，不做判断
				return entity;
			}
			versionNum = (Integer) m1.invoke(entity);
			//说明目前数据库中没有该条数据
			try {
				if ("null".equals(versionNum) || "".equals(versionNum) || null == versionNum) {
					Method m3 = (Method) objClass.getMethod("setVersionNum", Integer.class);
					m3.invoke(entity, 0);
					
					return entity;
				}
			} catch (Throwable e) {
				e.printStackTrace();
			}
			
			Method m2 = (Method) objClass.getMethod("getId");
			id = (String) m2.invoke(entity);

			if (null != id && !"".equals(id) && !"null".equals(id)) {
				//获得数据库中该条数据的version_num
				StringBuffer sqlBuffer = new StringBuffer("from " + objType + " ab where 1=1 ");
				sqlBuffer.append(" and ab.id = ? ");
				List<Object> listDb = this.findHql(sqlBuffer.toString(), id);

				if (null != listDb && listDb.size() > 0) {
					//当数据库中有该条数据时
					Method m4;
					m4 = (Method) objClass.getMethod("getVersionNum");
					numDb = (Integer) m4.invoke(listDb.get(0));
				}
			}
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			//e.printStackTrace();
			return entity;
		} catch (SecurityException e) {
			e.printStackTrace();
		}

		if (versionNum == numDb) {
			//提交的实体类的version_num与数据库中的version_num相等
			try {
				Method m5 = (Method) objClass.getMethod("setVersionNum", Integer.class);
				m5.invoke(entity, versionNum + 1);
			} catch (Throwable e) {
				e.printStackTrace();
			}
		} else {
			//若不相等，则抛出定义的异常
			throw new InterceptorException("");
		}
		return entity;
	}

	@Override
	public <T> void deleteLogic(T entity) {
		// TODO Auto-generated method stub
		try {
			PropertyUtils.setProperty(entity, "delflag", "1");
			this.saveOrUpdate(entity);
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
