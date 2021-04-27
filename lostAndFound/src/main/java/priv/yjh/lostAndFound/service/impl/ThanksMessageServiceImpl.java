package priv.yjh.lostAndFound.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import priv.yjh.lostAndFound.dao.ThanksMessageDao;
import priv.yjh.lostAndFound.domain.ThanksMessage;
import priv.yjh.lostAndFound.service.ThanksMessageService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ThanksMessageServiceImpl implements ThanksMessageService {

    @Autowired
    @Qualifier("thanksMessageDao")
    private ThanksMessageDao thanksMessageDao;

    @Override
    public Map queryThanksMessageAndTotal(int pageIndex, int pageSize, String keyword) {

        int skipCount=(pageIndex-1)*pageSize;

        Map map=new HashMap();

        map.put("pageSize",pageSize);
        map.put("skipCount",skipCount);
        map.put("keyword",keyword);

        //获取留言信息集合
        List<ThanksMessage> thanksMessageList=thanksMessageDao.findThanksMessage(map);

        //获取总条数
        int total=thanksMessageDao.findTotalCount();

        map.clear();
        map.put("thanksMessageList",thanksMessageList);
        map.put("total",total);

        return map;
    }

    @Override
    public boolean saveThanks(ThanksMessage thanksMessage) {

        boolean flag=false;

        int count=thanksMessageDao.saveThanks(thanksMessage);

        if(count==1) flag=true;

        return flag;
    }
}
