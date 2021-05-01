package priv.yjh.lostAndFound.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import priv.yjh.lostAndFound.constants.Constants;
import priv.yjh.lostAndFound.domain.User;
import priv.yjh.lostAndFound.exception.LoginException;
import priv.yjh.lostAndFound.exception.RegisterException;
import priv.yjh.lostAndFound.service.UserService;
import priv.yjh.lostAndFound.utils.DateTimeUtil;
import priv.yjh.lostAndFound.utils.MD5Util;
import priv.yjh.lostAndFound.utils.UUIDUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginAndRegisterController {

    @Autowired
    private UserService userService;

    //处理注册请求
    @RequestMapping("/register.do")
    @ResponseBody
    public Map register(User user,String code,HttpSession session) {

        Map map=new HashMap();

        user.setId(UUIDUtil.getUUID());
        user.setCreateTime(DateTimeUtil.getSysTime());
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        user.setWeChat(user.getWeChat());
        user.setRoleCode("user");

        if (!((String)session.getAttribute("Valicode")).toLowerCase().equals(code.toLowerCase())){
            map.put("success",false);
            map.put("msg","验证码输入有误！！！");
            return  map;
        }

        Boolean flag= null;
        try {
            flag = userService.register(user);
            if (flag){
                map.put("success",flag);
                map.put("msg","注册成功！");
            }else{
                map.put("success",false);
                map.put("msg","注册失败，请稍后重试！");
            }
        } catch (RegisterException e) {
            e.printStackTrace();
            map.put("success",false);
            map.put("msg",e.getMessage());
        }

        return map;
    }


    //登录验证
    @RequestMapping("/login.do")
    @ResponseBody
    public Map login(HttpSession session, User user, String code){

        Map map=new HashMap();

        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));

        if (!((String)session.getAttribute("Valicode")).toLowerCase().equals(code.toLowerCase())){
            map.put("success",false);
            map.put("msg","验证码输入有误！！！");
            return  map;
        }

        try {
            user=userService.login(user);
            session.setAttribute(Constants.USER,user);
            map.put("success",true);
            map.put("user",user);
        } catch (LoginException e) {
            e.printStackTrace();
            String msg=e.getMessage();
            map.put("success",false);
            map.put("msg",msg);
        }

        return map;
    }


}
