package priv.yjh.lostAndFound.dao;

import org.apache.ibatis.annotations.Param;
import priv.yjh.lostAndFound.domain.Notice;

import java.util.List;

public interface NoticeDao {

    Notice queryByState();

    int findCountByKeyword(String keyword);

    List<Notice> findAllByKeyword(@Param("skipCount") int skipCount,@Param("pageSize") int pageSize,@Param("keyword") String keyword);

    int add(Notice notice);

    int delete(@Param("ids") String[] ids);

    Notice findById(String id);

    int updateNotice(Notice notice);

    int setStateAsF();

    int updateState(Notice notice);
}
