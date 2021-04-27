package priv.yjh.lostAndFound.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import priv.yjh.lostAndFound.dao.LostThingsDao;
import priv.yjh.lostAndFound.domain.LostThings;
import priv.yjh.lostAndFound.service.LostThingsService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LostThingsServiceImpl implements LostThingsService {

    @Autowired
    private LostThingsDao lostThingsDao;

    //根据类型获取记录
    @Override
    public List<LostThings> queryAllByType(Integer currentPage,Integer pageSize,String type) {

        Integer skipCount=(currentPage-1)*pageSize;

        HashMap map=new HashMap();

        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        map.put("type",type);

        List<LostThings> lostThingsList=lostThingsDao.findAllByType(map);

        return lostThingsList;
    }

    //根据类型获取总记录数
    @Override
    public long queryCountByType(String type) {

        long count=lostThingsDao.findCountByType(type);

        return count;
    }

    //通过关键字获取记录
    @Override
    public List<LostThings> queryAllByKeyword(Integer currentPage, Integer pageSize, String keyword) {

        Integer skipCount=(currentPage-1)*pageSize;

        HashMap map=new HashMap();

        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        map.put("keyword",keyword);

        List<LostThings> lostThingsList=lostThingsDao.findAllByKeyword(map);

        return lostThingsList;
    }

    @Override
    public Integer queryCountByKeyword(String keyword) {

        Integer count=lostThingsDao.findCountByKeyword(keyword);

        return count;
    }

    @Override
    public LostThings queryNextByCondition(String publishTime, String keyword, String type) {

        Map map=new HashMap();

        map.put("publishTime",publishTime);
        map.put("keyword",keyword);
        map.put("type",type);

        LostThings lostThings=lostThingsDao.findNextByCondition(map);

        return lostThings;
    }

    @Override
    public LostThings queryPreviousByCondition(String publishTime, String keyword, String type) {

        Map map=new HashMap();

        map.put("publishTime",publishTime);
        map.put("keyword",keyword);
        map.put("type",type);

        LostThings lostThings=lostThingsDao.findPreviousByCondition(map);

        return lostThings;
    }

    @Override
    public LostThings queryDetailById(String id) {

        LostThings lostThings=lostThingsDao.findDetailById(id);

        return lostThings;
    }

    @Override
    public boolean modifyState(String id) {

        boolean flag=true;

        int count=lostThingsDao.updateState(id);

        if (count!=1) flag=false;

        return flag;
    }

    @Override
    public boolean save(LostThings lostThings) {

        boolean flag=true;

        int count=lostThingsDao.insert(lostThings);

        if (count!=1) flag=false;

        return flag;
    }

    @Override
    public List<LostThings> queryAllByUid(String user, int currentPage, int pageSize) {

        int skipCount=(currentPage-1)*pageSize;

        Map map=new HashMap();
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        map.put("user",user);

        List<LostThings> lostThingsList=lostThingsDao.findAllByUid(map);

        return lostThingsList;
    }

    @Override
    public int queryCountByUid(String user) {
        int total=lostThingsDao.findCountByUid(user);

        return total;
    }

    @Override
    public boolean deleteByIds(String[] idArr, int count) {

        boolean flag=false;

        int count1=lostThingsDao.deleteByIds(idArr);

        if (count1==count) flag=true;

        return flag;

    }
}
