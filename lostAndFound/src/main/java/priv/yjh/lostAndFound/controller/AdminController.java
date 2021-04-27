package priv.yjh.lostAndFound.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import priv.yjh.lostAndFound.domain.User;
import priv.yjh.lostAndFound.exception.LoginException;
import priv.yjh.lostAndFound.service.UserService;
import priv.yjh.lostAndFound.utils.MD5Util;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    //登录验证
    @RequestMapping("/login.do")
    @ResponseBody
    public Map login(User user, String code, HttpSession session){

        Map map=new HashMap();

        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));

        if (!((String)session.getAttribute("Valicode")).toLowerCase().equals(code.toLowerCase())){
            map.put("success",false);
            map.put("msg","验证码输入有误！！！");
            return  map;
        }

        try {
            user=userService.adminLogin(user);
            session.setAttribute("admin",user);
            map.put("success",true);
        } catch (LoginException e) {
            e.printStackTrace();
            String msg=e.getMessage();
            map.put("success",false);
            map.put("msg",msg);
        }

        return map;

    }

    //退出登录
    @RequestMapping("/logout.do")
    public String logout(HttpSession session){
        session.removeAttribute("admin");
        //重定向，要写完整的视图资源路径，以当前项目名为路径
        return "redirect:/admin/login.html";
    }

    //获取登录页面
    @RequestMapping("/login.html")
    public String getLoginJsp(){

        return "admin/login";

    }


    //获取后台首页
    @RequestMapping("/index.html")
    public String getIndexJsp(){

        return "admin/index";
    }

    //获取后台主页页面
    @RequestMapping("/main.html")
    public String getMainJsp(){

        return "admin/main";

    }

    //获取个人信息页面
    @RequestMapping("/personInfo.html")
    public String getPersonInfoJsp(){
        return "admin/personInfo";
    }

    @RequestMapping("/changepwd.html")
    public String getChangepwdJsp(){
        return "admin/changepwd";
    }

    @RequestMapping("/table.html")
    public String getTableJsp(){
        return "admin/table";
    }

    @RequestMapping("/table_1.html")
    public String getTable1Jsp(){
        return "admin/table_1";
    }

    @RequestMapping("/myLogInfo.html")
    public String getMyLogInfo(){
        return "admin/myloginfo";
    }

    @RequestMapping("/404.html")
    public String get404Jsp(){
        return "admin/404";
    }

    @RequestMapping("/tab.html")
    public String getTabJsp(){
        return "admin/tab";
    }

    /*@RequestMapping("/")
    public String get(){
        return "admin/";
    }

    @RequestMapping("/")
    public String get(){
        return "admin/";
    }*/
}
