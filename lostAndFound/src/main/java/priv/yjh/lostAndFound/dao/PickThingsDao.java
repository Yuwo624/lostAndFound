package priv.yjh.lostAndFound.dao;

import priv.yjh.lostAndFound.domain.PickThings;

import java.util.List;
import java.util.Map;

public interface PickThingsDao {
    List<PickThings> findAll(Map map);

    long findCountByType(String type);

    List<PickThings> findAllByKeyword(Map map);

    Integer findCountByKeyword(String keyword);

    PickThings findDetailById(String id);

    PickThings findNextByType(Map map);

    PickThings findPreviousByType(Map map);

    int updateState(String id);

    int insert(PickThings pickThings);

    List<PickThings> findAllByUid(Map map);

    int findCountByUid(String user);

    int deleteByIds(String[] idArr);

    int updateById(PickThings pickThings);


    PickThings findNextByKeyword(Map map);

    PickThings findPreviousByKeyword(Map map);
}
