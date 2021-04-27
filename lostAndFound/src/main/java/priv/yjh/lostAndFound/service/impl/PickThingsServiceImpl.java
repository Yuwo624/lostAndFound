package priv.yjh.lostAndFound.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import priv.yjh.lostAndFound.dao.PickThingsDao;
import priv.yjh.lostAndFound.domain.PickThings;
import priv.yjh.lostAndFound.service.PickThingsService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PickThingsServiceImpl implements PickThingsService {

    @Autowired//自动赋值，byType
    private PickThingsDao pickThingsDao;

    //获取所有记录
    @Override
    public List<PickThings> queryAllByType(Integer currentPage, Integer pageSize,String type) {

        Integer skipCount=(currentPage-1)*pageSize;

        System.out.println(pageSize);

        Map map=new HashMap();

        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        map.put("type",type);

        List<PickThings> pickThingsList=pickThingsDao.findAll(map);

        return pickThingsList;
    }

    //获取总条数
    @Override
    public long queryCountByType(String type) {
       long count=pickThingsDao.findCountByType(type);
       return count;
    }

    //根据关键字获取记录
    @Override
    public List<PickThings> queryAllByKeyword(Integer currentPage, Integer pageSize, String keyword) {

        Integer skipCount=(currentPage-1)*pageSize;

        Map map=new HashMap();

        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        map.put("keyword",keyword);

        List<PickThings> pickThingsList=pickThingsDao.findAllByKeyword(map);
        return pickThingsList;
    }

    //根据关键字查询总条数
    @Override
    public Integer queryCountByKeyword(String keyword) {

        Integer count=pickThingsDao.findCountByKeyword(keyword);

        return count;
    }

    //根据id查单条
    @Override
    public PickThings queryDetailById(String id) {

        PickThings pickThings=pickThingsDao.findDetailById(id);

        return pickThings;
    }

    //通过条件查询下一条
    @Override
    public PickThings queryNextByCondition(String publishTime, String keyword, String type) {

        Map map=new HashMap();

        map.put("publishTime",publishTime);
        map.put("keyword",keyword);
        map.put("type",type);

        PickThings pickThings=pickThingsDao.findNextByCondition(map);
        return pickThings;
    }

    //通过条件查询上一条
    @Override
    public PickThings queryPreviousByCondition(String publishTime, String keyword, String type) {
        Map map=new HashMap();

        map.put("publishTime",publishTime);
        map.put("keyword",keyword);
        map.put("type",type);

        PickThings pickThings=pickThingsDao.findPreviousByCondition(map);
        return pickThings;
    }

    //修改状态
    @Override
    public boolean modifyState(String id) {

        boolean flag=false;

        int count=pickThingsDao.updateState(id);

        if (count==1) flag=true;

        return flag;
    }

    //插入记录
    @Override
    public boolean save(PickThings pickThings) {

        boolean flag=true;

        int count=pickThingsDao.insert(pickThings);

        if (count!=1) flag=false;

        return true;
    }

    //根据用户id查所有
    @Override
    public List<PickThings> queryAllByUid(String user, int currentPage, int pageSize) {

        int skipCount=(currentPage-1)*pageSize;

        Map map=new HashMap();
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        map.put("user",user);

        List<PickThings> pickThingsList=pickThingsDao.findAllByUid(map);

        return pickThingsList;
    }

    //根据用户id查询记录数
    @Override
    public int queryCountByUid(String user) {

        int total=pickThingsDao.findCountByUid(user);

        return total;
    }

    //根据id数组删除记录
    @Override
    public boolean deleteByIds(String[] idArr, int count) {

        boolean flag=false;

        int count1=pickThingsDao.deleteByIds(idArr);

        if (count1==count) flag=true;

        return flag;
    }
}
