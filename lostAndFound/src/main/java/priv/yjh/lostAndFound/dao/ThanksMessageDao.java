package priv.yjh.lostAndFound.dao;

import priv.yjh.lostAndFound.domain.ThanksMessage;

import java.util.List;
import java.util.Map;

public interface ThanksMessageDao {

    List<ThanksMessage> findThanksMessage(Map map);

    int findTotalCount();

    int saveThanks(ThanksMessage thanksMessage);
}
