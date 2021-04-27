package priv.yjh.lostAndFound.service;

import priv.yjh.lostAndFound.domain.ThanksMessage;

import java.util.Map;

public interface ThanksMessageService {

    Map queryThanksMessageAndTotal(int pageIndex, int pageSize, String keyword);

    boolean saveThanks(ThanksMessage thanksMessage);
}
