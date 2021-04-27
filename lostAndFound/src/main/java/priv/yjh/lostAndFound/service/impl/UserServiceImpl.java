package priv.yjh.lostAndFound.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import priv.yjh.lostAndFound.exception.LoginException;
import priv.yjh.lostAndFound.dao.UserDao;
import priv.yjh.lostAndFound.domain.User;
import priv.yjh.lostAndFound.exception.RegisterException;
import priv.yjh.lostAndFound.service.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    @Qualifier("userDao")
    private UserDao userDao;

    //用户注册
    @Override
    public boolean register(User user) throws RegisterException {

        boolean flag=false;

        int count1=userDao.queryByAct(user);

        if (count1!=0){
            throw new RegisterException("该账号已被注册！");
        }

        int count2=userDao.registerUser(user);

        if (count2==1) flag=true;

        return flag;
    }

    //用户登录
    @Override
    public User login(User user) throws LoginException {

        user=userDao.login(user);

        if (user==null){
            throw new LoginException("账号密码错误！！！");
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

        if (count==1) flag=true;

        return flag;
    }

    //管理员登录
    @Override
    public User adminLogin(User user) throws LoginException {
        //验证用户是否为普通用户
        String roleCode=userDao.queryRoleCode(user);

        if (!"admin".equals(roleCode)){
            throw new LoginException("普通用户不能进入后台！");
        }

        user=userDao.login(user);

        return user;
    }
}
