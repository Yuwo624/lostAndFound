package priv.yjh.lostAndFound.service;

import priv.yjh.lostAndFound.domain.LostThings;

import java.util.List;



public interface LostThingsService {

    List<LostThings> queryAllByType(Integer currentPage,Integer pageSize,String type);

    long queryCountByType(String type);

    List<LostThings> queryAllByKeyword(Integer currentPage,Integer pageSize, String keyword);

    Integer queryCountByKeyword(String keyword);

    LostThings queryNextByCondition(String publishTime, String keyword, String type);

    LostThings queryPreviousByCondition(String publishTime, String keyword, String type);

    LostThings queryDetailById(String id);

    boolean modifyState(String id);

    boolean save(LostThings lostThings);

    List<LostThings> queryAllByUid(String user, int currentPage, int pageSize);

    int queryCountByUid(String user);

    boolean deleteByIds(String[] idArr, int count);
}
