package priv.yjh.lostAndFound.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Controller
@RequestMapping("/imgCode")
public class CodeController {

    private Random random = new Random();

    //随机生成begin和end之间的一个int值
    private int randNum(int begin, int end)

    {

        return random.nextInt(end - begin) + begin;

    }

    @RequestMapping("/code.do")
    public void getCode(HttpServletRequest request,HttpServletResponse response) throws IOException {

        System.out.println(1);

        // 首先设置浏览器不缓存
        response.setHeader("cache-control", "no-cache");

        response.setHeader("Expire", "-1"); // >0为缓存

        response.setHeader("pragma", "no-cache");

        // 存储正确的验证码

        String vali_code = "";

        String Vali_str = "abcdefghijklmnopqrstuvwsyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";

        Color[] colors =

                { Color.BLACK, Color.RED, Color.BLUE };

        // 1.创建图像

        int width = 110, height = 40;

        int x_offset = 5, y_offset = 28;

        BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);

        // 2.创建画布

        Graphics2D g = img.createGraphics();

        // 3.为画布添加背景颜色为亮灰色

        g.setColor(Color.LIGHT_GRAY);

        g.fillRect(0, 0, width, height);//fillRect是包括矩形框内部

        // 4.为画布添加边框

        g.setColor(Color.BLUE);

        g.drawRect(0, 0, width - 1, height - 1);//drawRect是绘制矩形边框

        // 5.绘制干扰线

        for (int i = 0; i < 10; i++)
        {
            g.setColor(new Color(randNum(0, 255), randNum(0, 255), randNum(0, 255)));

            g.drawLine(randNum(0, width), randNum(0, height), randNum(0, width), randNum(0, height));

        }
        g.setFont(new Font("黑体", Font.BOLD, 20));
        for (int i = 0; i < 4; i++)
        {
            int r = randNum(-180, 180);

            String code = Vali_str.charAt(randNum(0, Vali_str.length() - 1)) + "";

            g.rotate(r / 180 * Math.PI);

            g.setColor(colors[randNum(0, colors.length)]);

            g.drawString(code, x_offset + i * 30, y_offset);

            g.rotate(-r / 180 * Math.PI);

            vali_code += code;

        }

        System.out.println(vali_code);

        //将验证码的内容存储在HttpSession中

        HttpSession session = request.getSession();

        session.setAttribute("Valicode", vali_code);

        // 通过response的输出流打给浏览器

        ImageIO.write(img, "jpg", response.getOutputStream());
    }


}
