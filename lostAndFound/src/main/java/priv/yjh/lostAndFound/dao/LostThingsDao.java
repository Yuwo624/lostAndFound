package priv.yjh.lostAndFound.dao;

import priv.yjh.lostAndFound.domain.LostThings;

import java.util.List;
import java.util.Map;

public interface LostThingsDao {

    List<LostThings> findAllByType(Map map);

    long findCountByType(String type);

    List<LostThings> findAllByKeyword(Map map);

    Integer findCountByKeyword(String keyword);

    LostThings findNextByType(Map map);

    LostThings findPreviousByType(Map map);

    LostThings findDetailById(String id);

    int updateState(String id);

    int insert(LostThings lostThings);

    List<LostThings> findAllByUid(Map map);

    int findCountByUid(String user);

    int deleteByIds(String[] idArr);

    int updateById(LostThings lostThings);

    LostThings findNextByKeyword(Map map);

    LostThings findPreviousByKeyword(Map map);

    int deleteByUid(String id);
}
