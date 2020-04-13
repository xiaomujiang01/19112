package com.st.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.util.Arrays;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Email {
	
		public static void sendemail(String title,String info,String[] add_arr ) throws MessagingException, IOException {
			// 设置服务器的属性
			Properties props = new Properties();
			props.setProperty("mail.host", "smtp.163.com");// 设置QQ邮件服务器
			props.setProperty("mail.transport.protocol", "smtp");// 邮件发送协议
			props.setProperty("mail.smtp.auth", "true");// 需要验证用户名密码
			// 1创建会话
			Session session = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					// 发件人邮件用户名、授权码
					return new PasswordAuthentication("cuiqiang3368@163.com", "xiaoguaishou");

				}
			});
			// 开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
			session.setDebug(true);
			// 2通过session得到transport对象
			Transport t = session.getTransport();
			// 3使用邮箱的用户名和授权码连上邮件服务器
			t.connect("smtp.163.com", "cuiqiang3368@163.com", "MHIGTPFMPLJMYXLA");
			// 4邮件内容
			// 创建邮件对象
			MimeMessage message = new MimeMessage(session);

			// 指明邮件的发件人
			message.setFrom(new InternetAddress("cuiqiang3368@163.com"));

			// 指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
			InternetAddress[] I_add_arr=new InternetAddress[add_arr.length];
			for(int i=0;i<I_add_arr.length;i++) {
				System.out.println(add_arr[i]+"----------------------------add_arr");
				I_add_arr[i]=new InternetAddress(add_arr[i]); 
			}
			message.setRecipients(Message.RecipientType.TO, I_add_arr);

			// 邮件的标题
			message.setSubject(title);

			// 邮件的文本内容
			message.setContent(info, "text/html;charset=UTF-8");
//			String text = "";
//			URL url = new URL("https://www.easyicon.net/");
//			InputStream is = url.openStream();
//			char[] c_arr = new char[1024];
//			int l = 0;
//			Reader r = new InputStreamReader(is);
//			while ((l = r.read(c_arr)) > 0) {
//				text += new String(Arrays.copyOf(c_arr, l));
//			}
//			message.setContent(text, "text/html;charset=UTF-8");
			// 5发送邮件
			t.sendMessage(message, message.getAllRecipients());
			// 6关闭传输者流
			t.close();
		}

}
