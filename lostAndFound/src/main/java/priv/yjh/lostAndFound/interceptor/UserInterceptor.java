package priv.yjh.lostAndFound.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import priv.yjh.lostAndFound.domain.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserInterceptor implements HandlerInterceptor {

    //在处理方法执行之前执行
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session=request.getSession();

        User user= (User) session.getAttribute("user");

        if (user==null){
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write(
                    "<script>alert('请登录账号后，查看详细信息!');"
                            + "parent.window.document.location.href='"
                            + request.getContextPath()
                            + "/index.html';</script>");
            return false;
        }

        return true;
    }
}
