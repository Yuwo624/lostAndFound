package priv.yjh.lostAndFound.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import priv.yjh.lostAndFound.dao.NoticeDao;
import priv.yjh.lostAndFound.domain.Notice;
import priv.yjh.lostAndFound.service.NoticeService;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    NoticeDao noticeDao;

    @Override
    public Notice queryBySate() {

        Notice notice=noticeDao.queryByState();

        return notice;
    }
}
