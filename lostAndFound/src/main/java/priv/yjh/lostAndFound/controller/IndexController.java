package priv.yjh.lostAndFound.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import priv.yjh.lostAndFound.constants.Constants;
import priv.yjh.lostAndFound.domain.LostThings;
import priv.yjh.lostAndFound.domain.PickThings;
import priv.yjh.lostAndFound.domain.ThanksMessage;
import priv.yjh.lostAndFound.service.LostThingsService;
import priv.yjh.lostAndFound.service.PickThingsService;
import priv.yjh.lostAndFound.service.ThanksMessageService;
import priv.yjh.lostAndFound.tag.PagerTag;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController extends BaseController{

    @Value("10")
    private int pageSize;

    @Autowired
    private LostThingsService lostThingsService;
    @Autowired
    private PickThingsService pickThingsService;
    @Autowired
    private ThanksMessageService thanksMessageService;

    @RequestMapping(value={"/","/index.html"})
    public String index(Model model){
        System.out.println("请求转发index.jsp");

        //获取遗失物品信息
        List<LostThings> lostThingsList=lostThingsService.queryAllByType(1,15,"all");

        //获取捡到物品信息
        List<PickThings> pickThingsList=pickThingsService.queryAllByType(1,15,"all");

        //将上面连个参数存到request作用域中
        model.addAttribute("lostThingsList",lostThingsList);
        model.addAttribute("pickThingsList",pickThingsList);


        return "index";
    }

    // 搜索List
    @RequestMapping(value = { "/search-list.html" })
    public String searchAll(Map<String, Object> map, Model model, String keyword, HttpSession session) {

        List<PickThings> searchPickThingsList = pickThingsService.queryAllByKeyword(1,pageSize,keyword);
        List<LostThings> searchLostThingsList = lostThingsService.queryAllByKeyword(1,pageSize,keyword);
        int totalPick = pickThingsService.queryCountByKeyword(keyword);
        int totalLost = lostThingsService.queryCountByKeyword(keyword);

        model.addAttribute("keyword", keyword);
        session.setAttribute("keyword",keyword);

        this.initPickPage(map, 1,pageSize, totalPick);
        this.initLostPage(map, 1, pageSize, totalLost);
        super.initResult(model, "searchPickThingsList", searchPickThingsList, map);
        super.initResult(model, "searchLostThingsList", searchLostThingsList, map);

        return "search-list";
    }

    // 搜索功能分页
    @RequestMapping(value = { "/search-list.html/{pageNo}/{pageSizeStr}/{page}"})
    public String searchAllList(@PathVariable String pageNo,
                                @PathVariable String pageSizeStr, @PathVariable String page, String keyword, Map<String,
                                            Object> map, Model model) {


        List<PickThings> searchPickThingsList = pickThingsService.queryAllByKeyword(1,pageSize,keyword);
        List<LostThings> searchLostThingsList = lostThingsService.queryAllByKeyword(1,pageSize,keyword);

        int totalPick = pickThingsService.queryCountByKeyword(keyword);
        int totalLost = lostThingsService.queryCountByKeyword(keyword);

        int currentPage = 1;

        try {
            currentPage = Integer.parseInt(pageNo);
            pageSize = Integer.parseInt(pageSizeStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        //返回到前端
        model.addAttribute("keyword", keyword);
        model.addAttribute("pageName", page);

        this.initPickPage(map, currentPage, pageSize, totalPick);
        this.initLostPage(map, currentPage, pageSize, totalLost);

        super.initResult(model, "searchPickThingsList", searchPickThingsList, map);
        super.initResult(model, "searchLostThingsList", searchLostThingsList, map);

        return "search-list";
    }

    // 初始化分页相关信息
    private void initPickPage(Map<String, Object> map, Integer pageNum, Integer pageSize, Integer totalCount) {
        if (null == pageSize || pageSize.equals("")) {
            pageSize = this.pageSize;
        }
        if (pageSize > 50) {
            pageSize = 50;
        }
        Integer totalPage = (totalCount + pageSize - 1) / pageSize;
        if (null == pageNum) {
            pageNum = 1;
        } else if (pageNum > totalPage) {
            pageNum = totalPage;
        }
        map.put("pickstartIndex", PagerTag.getStartIndex(pageNum, pageSize));
        map.put("pickpageNum", pageNum);
        map.put("picktotalPage", totalPage);
        map.put("pickpageSize", pageSize);
        map.put("picktotalCount", totalCount);
    }

    // 初始化分页相关信息
    private void initLostPage(Map<String, Object> map, Integer pageNum, Integer pageSize, Integer totalCount) {
        if (null == pageSize || pageSize.equals("")) {
            pageSize = this.pageSize;
        }
        if (pageSize > 50) {
            pageSize = 50;
        }
        Integer totalPage = (totalCount + pageSize - 1) / pageSize;
        if (null == pageNum) {
            pageNum = 1;
        } else if (pageNum > totalPage) {
            pageNum = totalPage;
        }
        map.put("loststartIndex", PagerTag.getStartIndex(pageNum, pageSize));
        map.put("lostpageNum", pageNum);
        map.put("losttotalPage", totalPage);
        map.put("lostpageSize", pageSize);
        map.put("losttotalCount", totalCount);
    }

    //访问留言感谢页面
    @RequestMapping("/leave-thanks.html")
    public String getThanksView(){

        return "leave-thanks";

    }

    //获取留言信息分页
    @RequestMapping("/thanks.do")
    @ResponseBody
    public Map queryThanksMessageAndTotal(String pageIndex,String pageSize,HttpSession session){

        String keyword= (String) session.getAttribute("keyword");

        Map map=thanksMessageService.queryThanksMessageAndTotal(Integer.valueOf(pageIndex),Integer.valueOf(pageSize),keyword);

        List<ThanksMessage> thanksMessageList= (List<ThanksMessage>) map.get("thanksMessageList");

        return map;
    }

}
