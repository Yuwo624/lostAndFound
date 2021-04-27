package priv.yjh.lostAndFound.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminInterceptor implements HandlerInterceptor {

    //判断管理员是否登录，没有登录则跳转到登录界面
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {



       if (request.getSession().getAttribute("admin")==null){
           response.setCharacterEncoding("UTF-8");
           response.setContentType("text/html;charset=UTF-8");
           response.getWriter().write(
                   "<script>alert('请登录账号后，查看详细信息!');"
                           + "parent.window.document.location.href='"
                           + request.getContextPath()
                           + "/admin/login.html';</script>");
           return false;
       }

        return true;
    }
}
