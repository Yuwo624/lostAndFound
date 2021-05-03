package priv.yjh.lostAndFound.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import priv.yjh.lostAndFound.dao.NoticeDao;
import priv.yjh.lostAndFound.domain.Notice;
import priv.yjh.lostAndFound.service.NoticeService;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {



    @Autowired
    NoticeDao noticeDao;

    @Override
    public Notice queryBySate() {

        Notice notice=noticeDao.queryByState();

        return notice;
    }

    @Override
    public int queryCountByKeyword(String keyword) {

        int total=noticeDao.findCountByKeyword(keyword);

        return total;
    }

    @Override
    public List<Notice> queryAllByKeyword(int pageNo, int pageSize, String keyword) {

        int skipCount=(pageNo-1)*pageSize;

        List<Notice> noticeList=noticeDao.findAllByKeyword(skipCount,pageSize,keyword);

        return noticeList;
    }

    @Override
    public Boolean addNotice(Notice notice) {

        boolean flag=false;

        if(noticeDao.add(notice)==1) flag=true;

        return flag;
    }

    @Override
    public boolean deleteNotice(String[] ids) {

        boolean flag=false;

        int count=ids.length;

        if(noticeDao.delete(ids)==count) flag=true;

        return flag;
    }

    @Override
    public Notice queryById(String id) {

        Notice notice=noticeDao.findById(id);

        return notice;
    }

    @Override
    public boolean editNotice(Notice notice) {

        boolean flag=false;

       if(noticeDao.updateNotice(notice)==1) flag=true;

        return flag;
    }

    @Override
    public boolean updateNoticeState(Notice notice) {

        //根据id获取公告，判断是否发布
        Notice notice1=noticeDao.findById(notice.getId());

        if (notice1.getState()==0){
            //修改其它已发布的公告状态
            if(noticeDao.setStateAsF()!=1) return false;
            //修改当前id的发布状态
            notice.setState(1);
            if(noticeDao.updateState(notice)!=1) return false;
        }else{
            notice.setState(0);
            if (noticeDao.updateState(notice)!=1) return false;
        }


        return true;
    }
}
