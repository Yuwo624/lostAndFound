package priv.yjh.lostAndFound.service;

import priv.yjh.lostAndFound.domain.PickThings;

import java.util.List;

public interface PickThingsService {
    //查询所有记录
    List<PickThings> queryAllByType(Integer currentPage,Integer pageSize,String type);

    //根据类型查询总记录数
    long queryCountByType(String type);

    List<PickThings> queryAllByKeyword(Integer currentPage,Integer pageSize, String keyword);

    Integer queryCountByKeyword(String keyword);

    PickThings queryDetailById(String id);

    PickThings queryNextByCondition(String publishTime, String keyword, String type);

    PickThings queryPreviousByCondition(String publishTime, String keyword, String type);

    boolean modifyState(String id);

    boolean save(PickThings pickThings);

    List<PickThings> queryAllByUid(String user, int currentPage, int pageSize);

    int queryCountByUid(String user);

    boolean deleteByIds(String[] idArr, int count);
}
