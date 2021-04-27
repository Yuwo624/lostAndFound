package priv.yjh.lostAndFound.dao;

import priv.yjh.lostAndFound.domain.User;


public interface UserDao {
    int registerUser(User user);

    User login(User user);

    User findById(String id);

    int update(User user);

    int updateLoginPwd(User user);

    int queryByAct(User user);

    String queryRoleCode(User user);
}
