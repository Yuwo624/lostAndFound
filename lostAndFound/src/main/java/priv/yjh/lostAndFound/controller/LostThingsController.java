package priv.yjh.lostAndFound.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import priv.yjh.lostAndFound.domain.LostThings;
import priv.yjh.lostAndFound.service.LostThingsService;
import priv.yjh.lostAndFound.utils.DateTimeUtil;
import priv.yjh.lostAndFound.utils.MakeFolderUtil;
import priv.yjh.lostAndFound.utils.UUIDUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/lost")
public class LostThingsController extends BaseController{

    //每页默认条数
    @Value("10")
    private int pageSize;

    @Autowired
    private LostThingsService lostThingsService;

    //获取所有招领信息，分页
    @RequestMapping("/lost-list.html")
    public String lostThingsAll(HttpSession session,Model model, Map<String, Object> map) {

        int currentPage = 1;

        //访问当前方法时，说明浏览器页面在按照类型查询页面，将关键字移除
        session.removeAttribute("keyword");

        List<LostThings> lostThingsList = lostThingsService.queryAllByType(currentPage, pageSize, "all");

        long totalCount = lostThingsService.queryCountByType("all");
        super.initPage(map, currentPage, pageSize, (int) totalCount);
        super.initResult(model, "lostThingsList", lostThingsList, map);

        return "lost-list";
    }

    // 根据type查询lostThingsList
    @RequestMapping(value = { "/lost-list.do/{pageNo}/{pageSizeStr}/{type}", "/lost-list.html/{pageNo}/{pageSizeStr}/{type}" })
    public String lostThingsByType(@PathVariable String pageNo, @PathVariable String pageSizeStr, @PathVariable String type,
                                   Map<String, Object> map, Model model, HttpSession session) {

        int currentPage = 1;

        session.setAttribute("type",type);

        try {
            currentPage = Integer.parseInt(pageNo);
            pageSize = Integer.parseInt(pageSizeStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<LostThings> lostThingsList = lostThingsService.queryAllByType(currentPage,pageSize,type);
        long totalCount = lostThingsService.queryCountByType(type);
        super.initPage(map, currentPage, pageSize, (int) totalCount);
        super.initResult(model, "lostThingsList", lostThingsList, map);

        return "lost-list";
    }

    //根据id查单条
    @RequestMapping("/lost-details.html")
    public String getPickThingDetail(String id,Model model){

        LostThings lostThings=lostThingsService.queryDetailById(id);

        model.addAttribute("lostThings",lostThings);

        return "things/lost-details";

    }

    //查看下一条记录详细信息
    @RequestMapping("/lost-details.html/next.do")
    @ResponseBody
    public LostThings nextLostThings(String publishTime, HttpSession session){

        LostThings lostThings=null;
        //获取关键字，判断当前页面是否使用了搜索
        String keyword= (String) session.getAttribute("keyword");
        //获取失物类型，判断是否通过类型查询
        String type= (String) session.getAttribute("type");
        if (keyword!=null && keyword!=""){
            lostThings=lostThingsService.queryNextByKeyword(publishTime,keyword);
        }else{
            lostThings=lostThingsService.queryNextByType(publishTime,type);
        }


        return lostThings;

    }

    //查看上一条记录详细信息
    @RequestMapping("/lost-details.html/previous.do")
    @ResponseBody
    public LostThings previousLostThings(String publishTime,HttpSession session){
        LostThings lostThings=null;
        //获取关键字，判断当前页面是否使用了搜索
        String keyword= (String) session.getAttribute("keyword");
        //获取失物类型，判断是否通过类型查询
        String type= (String) session.getAttribute("type");
        if (keyword!=null && keyword!=""){
            lostThings=lostThingsService.queryPreviousByKeyword(publishTime,keyword);
        }else{
            lostThings=lostThingsService.queryPreviousByType(publishTime,type);
        }
        return lostThings;
    }

    //转发发表失物信息页面
    @RequestMapping("/lost-publish.html")
    public String getPublishView(){

        return "user/lost-publish";

    }

    //保存失物信息
    @RequestMapping("/savePublish.do")
    public String saveLostMessage(LostThings lostThings, @RequestParam(value = "publishImg",required = false) MultipartFile uploadFile, HttpServletRequest request){

        lostThings.setId(UUIDUtil.getUUID());
        lostThings.setState(0);
        lostThings.setPublishTime(DateTimeUtil.getSysTime());

        // 获取地址路径
        String basePath = super.getUploadBasePath(request) + "/lost";
        basePath = MakeFolderUtil.makeDir(basePath, new Date(), lostThings.getUser());

        String fileName = "";
        if (uploadFile.getOriginalFilename() != null
                && !"".equals(uploadFile.getOriginalFilename()))
            fileName = super.upload(uploadFile, basePath);

        if (fileName == null) {
            request.setAttribute("lostThings", lostThings);
            request.setAttribute("upErr", "图片上传失败!");

            return "user/lost-publish";
        }

        if(!"".equals(fileName)) {
            String savePath = basePath.substring(basePath.indexOf("static"));
            savePath = savePath + "/" + fileName;
            lostThings.setImg(savePath);
        }

        if (!lostThingsService.save(lostThings)) {
            request.setAttribute("lostThings", lostThings);
            request.setAttribute("saveErr", "发帖失败!");

            return "user/lost-publish";
        }

        return "redirect:/index.html";

    }
}
