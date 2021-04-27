package priv.yjh.lostAndFound.controller;

import java.io.File;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import priv.yjh.lostAndFound.constants.Constants;
import priv.yjh.lostAndFound.tag.PagerTag;
import priv.yjh.lostAndFound.utils.DateTimeUtil;



public abstract class BaseController {

	
	// 初始化分页相关信息
	protected void initPage(Map<String, Object> map, Integer pageNum,
			Integer pageSize, Integer totalCount) {
		if (null == pageSize || pageSize.equals("")) {
			pageSize = Constants.PAGE_SIZE_15;
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
		map.put("startIndex", PagerTag.getStartIndex(pageNum, pageSize));
		map.put("pageNum", pageNum);
		map.put("totalPage", totalPage);
		map.put("pageSize", pageSize);
		map.put("totalCount", totalCount);
	}

	// 将相关数据放入model
	protected void initResult(Model model, String listKey, List<?> list,
			Map<String, Object> map) {
		model.addAttribute(listKey, list);
		Iterator<Entry<String, Object>> it = map.entrySet().iterator();
		while (it.hasNext()) {
			Entry<String, Object> m = (Entry<String, Object>) it.next();
			model.addAttribute(m.getKey().toString(), m.getValue());
		}
	}
	
	// 上传图片
	protected String upload(MultipartFile multipartFile, String  basePath) {
		// 取文件的类型，后缀名
		String fileType = multipartFile.getOriginalFilename().substring(
				multipartFile.getOriginalFilename().lastIndexOf("."));
		
		// 构建一个随机文件名称，以日期时分秒作为文件名称，避免高并发时，文件名重复
		String fileName = DateTimeUtil.format(new Date(), "yyyyMMddHHmmssS") + fileType;
		//System.out.println("fileName: " +fileName);
		// Java IO的内容
		File targetFile = new File(basePath, fileName);

		// 保存
		try {
			// 转移到
			(multipartFile).transferTo(targetFile);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return fileName;
	}
	
	// 获取上传根路径
	protected String getUploadBasePath(HttpServletRequest request) {
		 return request.getServletContext().getRealPath(Constants.BASE_UPLOAD_PATH);
	}
}
