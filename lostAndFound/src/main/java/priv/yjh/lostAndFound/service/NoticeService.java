package priv.yjh.lostAndFound.service;

import priv.yjh.lostAndFound.domain.Notice;

import java.util.List;

public interface NoticeService {

    Notice queryBySate();

    int queryCountByKeyword(String keyword);

    List<Notice> queryAllByKeyword(int pageNo, int pageSize, String keyword);

    Boolean addNotice(Notice notice);

    boolean deleteNotice(String[] ids);

    Notice queryById(String id);

    boolean editNotice(Notice notice);

    boolean updateNoticeState(Notice notice);
}
