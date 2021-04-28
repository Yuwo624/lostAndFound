package priv.yjh.lostAndFound.dao;

import org.apache.ibatis.annotations.Param;
import priv.yjh.lostAndFound.domain.User;

import java.util.List;


public interface UserDao {
    int registerUser(User user);

    User login(User user);

    User findById(String id);

    int update(User user);

    int updateLoginPwd(User user);

    User queryByAct(String loginAct);

    String queryRoleCode(User user);

    List<User> findAll(@Param("skipCount") int skipCount, @Param("pageSize") int pageSize, @Param("keyword") String keyword);

    int findAllCount(String keyword);

    int delete(String[] userIds);
}
