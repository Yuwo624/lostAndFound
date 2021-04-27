package priv.yjh.lostAndFound.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import priv.yjh.lostAndFound.dao.ThingsTypeDao;
import priv.yjh.lostAndFound.service.ThingsTypeService;

import java.util.List;
import java.util.Map;

@Service
public class ThingsTypeServiceImpl implements ThingsTypeService {

    @Autowired
    @Qualifier("thingsTypeDao")
    ThingsTypeDao thingsTypeDao;

    @Override
    public List<Map> getThingsType() {

        List<Map> list=thingsTypeDao.selectAll();

        return list;
    }
}
