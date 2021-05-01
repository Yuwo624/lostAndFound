package priv.yjh.lostAndFound.web.listener;

import org.springframework.web.context.support.WebApplicationContextUtils;
import priv.yjh.lostAndFound.constants.Constants;
import priv.yjh.lostAndFound.domain.Notice;
import priv.yjh.lostAndFound.service.NoticeService;
import priv.yjh.lostAndFound.service.ThingsTypeService;


import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Calendar;
import java.util.List;
import java.util.Map;


public class ApplicationListener implements ServletContextListener {


	@Override
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		//这里不能使用注解注入，否则会出现异常
		/*
			注解的方式执行的位置，spring的注入是在filter和listener之后的，（顺序是这样的listener >> filter >> servlet >> spring ）
			也就是说监听中进行注解注入时，监听器已经初始化了，但是bean还没有注入
		 */
		ThingsTypeService thingsTypeService= (ThingsTypeService) WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext()).getBean("thingsTypeServiceImpl");

		//获取web应用的根路径
		ServletContext servletContext = servletContextEvent.getServletContext();
		System.out.println("初始化path：" +servletContext.getContextPath());

		servletContext.setAttribute(Constants.PATH, servletContext.getContextPath());
		
		// 当前年份
		servletContext.setAttribute("thisYear", Calendar.getInstance().get(Calendar.YEAR));

		List<Map> list=thingsTypeService.getThingsType();

		//添加类型词典到全局作用域中
		servletContext.setAttribute("thingsTypeList",list);



	}

}
