package priv.yjh.lostAndFound.service;

import priv.yjh.lostAndFound.exception.LoginException;
import priv.yjh.lostAndFound.domain.User;
import priv.yjh.lostAndFound.exception.RegisterException;

public interface UserService {

    boolean register(User user) throws RegisterException;
    User login(User user) throws LoginException;

    User queryById(String id);

    boolean update(User user);

    boolean modifyLoginPwd(User user);

    User adminLogin(User user) throws LoginException;
}
