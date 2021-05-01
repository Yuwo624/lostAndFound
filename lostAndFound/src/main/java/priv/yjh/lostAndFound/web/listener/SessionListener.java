package priv.yjh.lostAndFound.web.listener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import priv.yjh.lostAndFound.domain.Notice;
import priv.yjh.lostAndFound.service.NoticeService;

import javax.annotation.Resource;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener {
    @Override
    public void sessionCreated(HttpSessionEvent se) {

        //获取spring容器对象
        ApplicationContext act= WebApplicationContextUtils.getWebApplicationContext(se.getSession().getServletContext());

        NoticeService noticeService= (NoticeService) act.getBean("noticeServiceImpl");

        Notice notice=noticeService.queryBySate();

        se.getSession().setAttribute("notice",notice);
    }
}
