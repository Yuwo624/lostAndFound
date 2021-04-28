package priv.yjh.lostAndFound.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import priv.yjh.lostAndFound.exception.LoginException;
import priv.yjh.lostAndFound.domain.LostThings;
import priv.yjh.lostAndFound.domain.PickThings;
import priv.yjh.lostAndFound.domain.ThanksMessage;
import priv.yjh.lostAndFound.domain.User;
import priv.yjh.lostAndFound.service.LostThingsService;
import priv.yjh.lostAndFound.service.PickThingsService;
import priv.yjh.lostAndFound.service.ThanksMessageService;
import priv.yjh.lostAndFound.service.UserService;
import priv.yjh.lostAndFound.utils.DateTimeUtil;
import priv.yjh.lostAndFound.utils.MD5Util;
import priv.yjh.lostAndFound.utils.UUIDUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private LostThingsService lostThingsService;

    @Autowired
    private PickThingsService pickThingsService;

    @Autowired
    ThanksMessageService thanksMessageService;


    //退出登录
    @RequestMapping("/logout.do")
    public String logout(HttpServletRequest request){
        //将user从session域中移除
        request.getSession().removeAttribute("user");

        //重定向到index页面
        return "redirect:/index.html";
    }

    // 用户中心
    @RequestMapping("/user-center.html")
    public String userCenter() {

        return "user/user-center";
    }

    // 获取个人中心默认视图
    @RequestMapping( "/default.html" )
    public String defaultView() {

        return "user/default";
    }

    // 获取用户信息视图
    @RequestMapping("user-info.do")
    public String userInfoView() {

        return "user/user-info";
    }


    //通过id获取用户信息
    @RequestMapping("/queryById.do")
    @ResponseBody
    public User queryById(String userId){

        User user=userService.queryById(userId);

        return user;
    }

    //更新用户信息
    @RequestMapping(value={"/updateUser.do"})
    @ResponseBody
    public Map<String,Object> updateUser(User user, HttpSession session){
        Map<String, Object> map = new HashMap<String, Object>();

        boolean flag=userService.update(user);

        if(flag) {
            //重新获取user，
            user=userService.queryByAct(user.getLoginAct());
            System.out.println(user.getNickname());
            map.put("msg", "success");
            session.setAttribute("user",user);
        } else {
            map.put("msg", "error");
        }
        return map;
    }

    //获取修改密码视图页面
    @RequestMapping("/updateLoginPwd.html")
    public String updateLoginPwdView(){
        return "user/user-password";
    }

    //更新用户密码
    @RequestMapping("/updateLoginPwd.do")
    @ResponseBody
    public Map updateLoginPwd(User user,String password,String newPassword,HttpSession session) throws LoginException {


        Map<String, Object> map = new HashMap<String, Object>();

        //检验原密码是否正确，正确进行修改
        if (user.getId()==null){
            user.setLoginPwd(MD5Util.getMD5(password));
            if (userService.login(user)!=null)
                map.put("msg", "success");
			else
                map.put("msg", "error");
        }else{
            user.setLoginPwd(MD5Util.getMD5(newPassword));
            if (userService.modifyLoginPwd(user)) {
                map.put("msg", "success");
                //修改成功，将user从session域中移除，通知用户重新登录
                session.removeAttribute("user");
            } else {
                map.put("msg", "error");
            }
        }

        return map;

    }

    //获取招领列表页面
    @RequestMapping("/findInfo.html")
    public String findInfoView(){

        return "user/find-info";

    }

    //获取招领信息列表分页
    @RequestMapping("/getFindInfo.do")
    @ResponseBody
    public Map getFindInfoByUid(int page, int rows, HttpSession session){

        String user=((User)session.getAttribute("user")).getId();

        Map<String, Object> jsonMap = new HashMap<String, Object>();
        List<PickThings> pickThingsList = pickThingsService.queryAllByUid(user, page, rows);
        int total=pickThingsService.queryCountByUid(user);

        jsonMap.put("total", total);
        jsonMap.put("rows", pickThingsList);

        return jsonMap;

    }

    //根据id删除招领信息
    @RequestMapping("/deleteFindInfo.do")
    @ResponseBody
    public Map<String,Boolean> deleteFindInfo(String ids){
        //获取id数组
        String[] idArr=ids.split(",");


        boolean success=pickThingsService.deleteByIds(idArr);

        Map<String,Boolean> map=new HashMap<>();

        map.put("success",success);

        return map;

    }

    //获取失物信息列表
    @RequestMapping("/lostInfo.html")
    public String lostInfoView(){
        return "user/lost-info";
    }

    //获取失物信息列表分页
    @RequestMapping("/getLostInfo.do")
    @ResponseBody
    public Map getLostInfoByUid(int page, int rows, HttpSession session){

        String user=((User)session.getAttribute("user")).getId();

        Map<String, Object> jsonMap = new HashMap<String, Object>();
        List<LostThings> lostThingsList = lostThingsService.queryAllByUid(user, page, rows);
        int total=lostThingsService.queryCountByUid(user);

        jsonMap.put("total", total);
        jsonMap.put("rows", lostThingsList);

        return jsonMap;

    }

    //根据id删除招领信息
    @RequestMapping("/deleteLostInfo.do")
    @ResponseBody
    public Map<String,Boolean> deleteLostInfo(String ids){
        //获取id数组
        String[] idArr=ids.split(",");

        boolean success=lostThingsService.deleteByIds(idArr);

        Map<String,Boolean> map=new HashMap<>();

        map.put("success",success);

        return map;

    }

    //更新寻物失物状态
    @RequestMapping("/updateLostState.do")
    @ResponseBody
    public Map updateLostState(String id){

        boolean flag=lostThingsService.modifyState(id);

        Map map=new HashMap();

        map.put("success",flag);

        return map;
    }

    //更新招领失物状态
    @RequestMapping("/updateFindState.do")
    @ResponseBody
    public Map updateFindState(String id){

        boolean flag=pickThingsService.modifyState(id);

        Map map=new HashMap();

        map.put("success",flag);

        return map;
    }

    //保存留言信息
    @RequestMapping("/saveThanks.do")
    @ResponseBody
    public Map saveThanks(ThanksMessage thanksMessage){

        thanksMessage.setId(UUIDUtil.getUUID());
        thanksMessage.setPublishTime(DateTimeUtil.getSysTime());

        boolean flag=thanksMessageService.saveThanks(thanksMessage);

        Map map=new HashMap();

        map.put("success",flag);

        return map;
    }
}
