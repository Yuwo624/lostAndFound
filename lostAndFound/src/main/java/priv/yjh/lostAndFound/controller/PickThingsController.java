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
import priv.yjh.lostAndFound.domain.PickThings;
import priv.yjh.lostAndFound.service.PickThingsService;
import priv.yjh.lostAndFound.utils.DateTimeUtil;
import priv.yjh.lostAndFound.utils.MakeFolderUtil;
import priv.yjh.lostAndFound.utils.UUIDUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/find")
public class PickThingsController extends BaseController{

    //每页默认条数
    @Value("10")
    private int pageSize;

    @Autowired
    private PickThingsService pickThingsService;

    // 查询所有pickThings
    @RequestMapping("/find-list.html")
    public String getPickThingsAll(Model model, Map<String, Object> map,HttpSession session) {

        //当前页
        int currentPage = 1;


        //访问当前方法时，说明浏览器页面在按照类型查询页面，将关键字移除
        session.removeAttribute("keyword");

        String type="all";

        session.setAttribute("type",type);

        List<PickThings> pickThingsList = pickThingsService.queryAllByType(currentPage,pageSize,type);
        long totalCount = pickThingsService.queryCountByType(type);
        super.initPage(map, currentPage, pageSize, (int) totalCount);
        super.initResult(model, "pickThingsList", pickThingsList, map);

        return "find-list";
    }

    // 根据type查询pickThingsList
    @RequestMapping(value = { "/find-list.do/{pageNo}/{pageSizeStr}/{type}", "/find-list.html/{pageNo}/{pageSizeStr}/{type}" })
    public String getPickThingsByType(@PathVariable String pageNo, @PathVariable String pageSizeStr, @PathVariable String type,
                                 Map<String, Object> map, Model model,HttpSession session) {

        int currentPage = 1;

        session.setAttribute("type",type);

        try {
            currentPage = Integer.parseInt(pageNo);
            pageSize = Integer.parseInt(pageSizeStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<PickThings> pickThingsList = pickThingsService.queryAllByType(currentPage,pageSize,type);
        long totalCount = pickThingsService.queryCountByType(type);
        super.initPage(map, currentPage, pageSize, (int) totalCount);
        super.initResult(model, "pickThingsList", pickThingsList, map);

        return "find-list";
    }

    //根据id查单条
    @RequestMapping("/find-details.html")
    public String getPickThingDetail(String id,Model model){

        PickThings pickThings=pickThingsService.queryDetailById(id);

        model.addAttribute("pickThings",pickThings);

        return "things/find-details";

    }

    //查看下一条记录详细信息
    @RequestMapping("/find-details.html/next.do")
    @ResponseBody
    public PickThings nextPickThings(String publishTime, HttpSession session){

        PickThings pickThings=null;

        if (session.getAttribute("keyword")!=null && session.getAttribute("keyword")!=""){
            //有关键字时，按照关键字进行下一条
            String keyword= (String) session.getAttribute("keyword");
            pickThings=pickThingsService.queryNextByKeyword(publishTime,keyword);
        }else{
            //获取失物类型，判断是否通过类型查询
            String type= (String) session.getAttribute("type");

            pickThings=pickThingsService.queryNextByType(publishTime,type);
        }



        return pickThings;

    }

    //查看上一条记录详细信息
    @RequestMapping("/find-details.html/previous.do")
    @ResponseBody
    public PickThings previousPickThings(String publishTime,HttpSession session){

        PickThings pickThings=null;

        if (session.getAttribute("keyword")!=null && session.getAttribute("keyword")!=""){
            //有关键字时，按照关键字进行上一条
            String keyword= (String) session.getAttribute("keyword");
            pickThings=pickThingsService.queryPreviousByKeyword(publishTime,keyword);
        }else{
            //获取失物类型，判断是否通过类型查询
            String type= (String) session.getAttribute("type");

            pickThings=pickThingsService.queryPreviousByType(publishTime,type);
        }

        return pickThings;
    }

    //转发发表招领信息页面
    @RequestMapping("/find-publish.html")
    public String getPublishView(){

        return "user/find-publish";

    }

    //保存招领信息
    @RequestMapping("/savePublish.do")
    public String saveLostMessage(PickThings pickThings, @RequestParam(value = "publishImg",required = false) MultipartFile uploadFile, HttpServletRequest request){

        pickThings.setId(UUIDUtil.getUUID());
        pickThings.setState(0);
        pickThings.setPublishTime(DateTimeUtil.getSysTime());

        // 获取地址路径
        String basePath = super.getUploadBasePath(request) + "/find";
        basePath = MakeFolderUtil.makeDir(basePath, new Date(), pickThings.getUser());

        String fileName = "";
        if (uploadFile.getOriginalFilename() != null
                && !"".equals(uploadFile.getOriginalFilename()))
            fileName = super.upload(uploadFile, basePath);

        if (fileName == null) {
            request.setAttribute("pickThings", pickThings);
            request.setAttribute("upErr", "图片上传失败!");

            return "user/find-publish";
        }

        if(!"".equals(fileName)) {
            String savePath = basePath.substring(basePath.indexOf("static"));
            savePath = savePath + "/" + fileName;
            pickThings.setImg(savePath);
        }

        if (!pickThingsService.save(pickThings)) {
            request.setAttribute("pickThings", pickThings);
            request.setAttribute("saveErr", "发帖失败!");

            return "user/find-publish";
        }

        return "redirect:/index.html";

    }
}
