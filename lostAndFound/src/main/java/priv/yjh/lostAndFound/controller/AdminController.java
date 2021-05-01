package priv.yjh.lostAndFound.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import priv.yjh.lostAndFound.constants.Constants;
import priv.yjh.lostAndFound.domain.LostThings;
import priv.yjh.lostAndFound.domain.PickThings;
import priv.yjh.lostAndFound.domain.User;
import priv.yjh.lostAndFound.exception.LoginException;
import priv.yjh.lostAndFound.exception.RegisterException;
import priv.yjh.lostAndFound.service.LostThingsService;
import priv.yjh.lostAndFound.service.PickThingsService;
import priv.yjh.lostAndFound.service.UserService;
import priv.yjh.lostAndFound.utils.DateTimeUtil;
import priv.yjh.lostAndFound.utils.MD5Util;
import priv.yjh.lostAndFound.utils.UUIDUtil;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private PickThingsService pickThingsService;

    @Autowired
    private LostThingsService lostThingsService;

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
            session.setAttribute(Constants.ADMIN,user);
            map.put("success",true);
        } catch (LoginException e) {
            e.printStackTrace();
            String msg=e.getMessage();
            map.put("success",false);
            map.put("msg",msg);
        }

        return map;

    }

    //更新用户信息
    @RequestMapping(value={"/updateAdmin.do"})
    @ResponseBody
    public Map<String,Object> updateAdmin(User user, HttpSession session){
        Map<String, Object> map = new HashMap<String, Object>();

        boolean flag=userService.update(user);

        if(flag) {
            //重新获取user，
            user=userService.queryByAct(user.getLoginAct());
            System.out.println(user.getNickname());
            map.put("msg", "success");
            session.setAttribute("admin",user);
        } else {
            map.put("msg", "error");
        }
        return map;
    }

    //修改登录密码
    @RequestMapping("/updatePwd.do")
    @ResponseBody
    public Map<String,Object> updatePwd(User user,String oldPassword,HttpSession session){

        Map<String,Object> map=new HashMap<>();

        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));

        String msg="修改失败，请稍后重试!!!";

        map.put("msg",msg);

        oldPassword=MD5Util.getMD5(oldPassword);

        if (!oldPassword.equals(((User)session.getAttribute("admin")).getLoginPwd())){
            msg="旧密码输入错误！！！";
            map.put("success",false);
            map.put("msg",msg);
            return map;
        }

        boolean flag=userService.modifyLoginPwd(user);

        if(flag) session.removeAttribute("admin");

        map.put("success",flag);

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
    @RequestMapping(value={"/","/login.html"})
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

    //获取用户列表页面
    @RequestMapping("/userList.html")
    public String userListJsp(){

        return "admin/userList";
    }

    //获取用户列表分页
    @RequestMapping("/getUserList.do")
    @ResponseBody
    public Map<String,Object> getUserList(String pageNo,String pageSize,String keyword){

        int skipCount=(Integer.valueOf(pageNo)-1)*Integer.valueOf(pageSize);

        List<User> userList=userService.queryAll(skipCount,Integer.valueOf(pageSize),keyword);
        int total=userService.queryAllCount(keyword);

        Map<String,Object> map=new HashMap<>();
        map.put("userList",userList);
        map.put("total",total);

        return map;
    }

    //添加新用户
    @RequestMapping("/addUser.do")
    @ResponseBody
    public Map<String,Object> registerUser(User user){

        Map map=new HashMap();

        user.setId(UUIDUtil.getUUID());
        user.setCreateTime(DateTimeUtil.getSysTime());
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));

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

    //批量删除用户
    @RequestMapping("/deleteUser.do")
    @ResponseBody
    public Map<String,Boolean> deleteUser(String[] userIds){

        boolean flag=userService.delete(userIds);

        Map<String,Boolean> map=new HashMap<>();

        map.put("success",flag);

        return map;

    }

    //通过id获取用户信息
    @RequestMapping("/queryUserById.do")
    @ResponseBody
    public User queryById(String userId){

        User user=userService.queryById(userId);

        return user;
    }

    //更新用户信息
    @RequestMapping("/updateUser.do")
    @ResponseBody
    public Map<String,Object> updateUser(User user,HttpSession session){

        String success="0";

        Map<String,Object> map=new HashMap<>();


        Boolean flag=userService.update(user);

        if (flag){
            if (((User)session.getAttribute("admin")).getId().equals(user.getId())){
                success="2";
                session.removeAttribute("admin");
            }else {
                success="1";
            }
        }
        map.put("success",success);
        return map;
    }

    //获取招领信息页面
    @RequestMapping("/findList.html")
    public String getFindListJsp(){
        return "admin/findList";
    }

    //获取招领信息
    @RequestMapping("/getFindList.do")
    @ResponseBody
    public Map<String,Object> getFindList(int pageNo,int pageSize,String keyword){

        Map<String,Object> map=new HashMap<>();

        int total=pickThingsService.queryCountByKeyword(keyword);

        List<PickThings> findList=pickThingsService.queryAllByKeyword(pageNo,pageSize,keyword);

        map.put("total",total);
        map.put("findList",findList);

        return map;

    }

    //批量删除招领信息
    @RequestMapping("/deleteFind.do")
    @ResponseBody
    public Map<String,Boolean> deleteFind(String[] findIds){

        boolean flag=pickThingsService.deleteByIds(findIds);

        Map<String,Boolean> map=new HashMap<>();

        map.put("success",flag);

        return map;

    }

    //获取单条招领信息
    @RequestMapping("/queryFindById.do")
    @ResponseBody
    public PickThings getFindById(String id){
        PickThings pickThings=pickThingsService.queryDetailById(id);
        return pickThings;
    }

    //更新单条招领信息
    @RequestMapping("/updateFind.do")
    @ResponseBody
    public Map<String,Boolean> updateFind(PickThings pickThings){

        boolean success=pickThingsService.updateById(pickThings);

        Map<String,Boolean> map=new HashMap<>();

        map.put("success",success);

        return map;

    }

    //获取寻物信息页面
    @RequestMapping("/lostList.html")
    public String getLostListJsp(){
        return "admin/lostList";
    }

    //获取寻物信息
    @RequestMapping("/getLostList.do")
    @ResponseBody
    public Map<String,Object> getLostList(int pageNo,int pageSize,String keyword){

        Map<String,Object> map=new HashMap<>();

        int total=lostThingsService.queryCountByKeyword(keyword);

        List<LostThings> lostList=lostThingsService.queryAllByKeyword(pageNo,pageSize,keyword);

        map.put("total",total);
        map.put("lostList",lostList);

        return map;

    }

    //批量删除寻物信息
    @RequestMapping("/deleteLost.do")
    @ResponseBody
    public Map<String,Boolean> deleteLost(String[] lostIds){

        boolean flag=lostThingsService.deleteByIds(lostIds);

        Map<String,Boolean> map=new HashMap<>();

        map.put("success",flag);

        return map;

    }

    //获取单条寻物信息
    @RequestMapping("/queryLostById.do")
    @ResponseBody
    public LostThings getLostById(String id){
        LostThings lostThings=lostThingsService.queryDetailById(id);
        return lostThings;
    }

    //更新单条寻物信息
    @RequestMapping("/updateLost.do")
    @ResponseBody
    public Map<String,Boolean> updateLost(LostThings lostThings){

        boolean success=lostThingsService.updateById(lostThings);

        Map<String,Boolean> map=new HashMap<>();

        map.put("success",success);

        return map;

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
