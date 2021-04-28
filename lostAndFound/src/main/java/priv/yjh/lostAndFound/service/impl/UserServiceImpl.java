package priv.yjh.lostAndFound.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import priv.yjh.lostAndFound.exception.LoginException;
import priv.yjh.lostAndFound.dao.UserDao;
import priv.yjh.lostAndFound.domain.User;
import priv.yjh.lostAndFound.exception.RegisterException;
import priv.yjh.lostAndFound.service.UserService;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    @Qualifier("userDao")
    private UserDao userDao;

    //用户注册
    @Override
    public boolean register(User user) throws RegisterException {

        boolean flag=false;

        User user1=userDao.queryByAct(user.getLoginAct());

        if (user1!=null){
            throw new RegisterException("该账号已被注册！");
        }

        int count2=userDao.registerUser(user);

        if (count2==1) flag=true;

        return flag;
    }

    //查询所有用户
    @Override
    public List<User> queryAll(int skipCount, int pageSize, String keyword) {

        List<User> userList=userDao.findAll(skipCount,pageSize,keyword);

        return userList;
    }

    //查询用户总数量
    public int queryAllCount(String keyword){
        int total=userDao.findAllCount(keyword);
        return total;
    }

    @Override
    public boolean delete(String[] userIds) {

        Boolean flag=false;

        int count1=userIds.length;

        int count2=userDao.delete(userIds);

        if (count1==count2) flag=true;

        return flag;
    }

    //用户登录
    @Override
    public User login(User user) throws LoginException {

        user=userDao.login(user);

        if (user==null){
            throw new LoginException("账号密码错误！！！");
        }else if (user.getLockState()!=1){
            throw new LoginException("账号已被冻结，请联系管理员进行申述！！！");
        }

        return user;
    }

    //根据id查单条
    @Override
    public User queryById(String id) {

        User user=userDao.findById(id);

        return user;
    }

    //修改用户信息
    @Override
    public boolean update(User user) {

        Boolean flag=false;

        int count=userDao.update(user);

        if (count==1) flag=true;

        return true;
    }

    @Override
    public boolean modifyLoginPwd(User user) {

        boolean flag=false;

        int count=userDao.updateLoginPwd(user);

        System.out.println("count="+count);

        if (count==1) flag=true;

        return flag;
    }

    //管理员登录
    @Override
    public User adminLogin(User user) throws LoginException {
        //验证用户是否为普通用户
        String roleCode=userDao.queryRoleCode(user);

        if (!"admin".equals(roleCode) && !"superAdmin".equals(roleCode)){
            throw new LoginException("普通用户不能进入后台！");
        }

        user=userDao.login(user);

        if(user==null){
            throw new LoginException("账号密码输入错误！！！");
        }

        return user;
    }

    @Override
    public User queryByAct(String loginAct) {

        User user=userDao.queryByAct(loginAct);

        return user;
    }
}
