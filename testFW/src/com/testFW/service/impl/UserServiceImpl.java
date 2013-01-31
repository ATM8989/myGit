package com.testFW.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.testFW.bo.InvitationCodeBO;
import com.testFW.bo.UserBO;
import com.testFW.bo.UserInfoBO;
import com.testFW.dao.UserDao;
import com.testFW.service.UserService;
import com.testFW.util.StringUtil;
import com.testFW.util.UserUtil;

/**
 * 用户业务处理接口实现类
 * @author Kalor
 * @time 2012-12-17
 */
public class UserServiceImpl implements UserService{
	private UserDao userDao;
	public void setUserDao(UserDao dao) {
		this.userDao = dao;
	}
	@Override
	public boolean verifyCode(String code) {
		InvitationCodeBO codeBO = userDao.queryInvitationCode(code);
		if(codeBO!=null&&codeBO.getState()==0) {
			/*
			 * 除了万能邀请码lovegaozhuqing之外，其余邀请码一律置状态为不可用
			 */
			if(!"lovegaozhuqing".equals(codeBO.getCode())){
				userDao.updateInvitationCodeState(codeBO);
			}
			
			return true;
		}else {
			return false;
		}
	}
	@Override
	public boolean regist(String email, String name, String pass) {
		pass = StringUtil.passEncrypt(pass);
		//第一次注册用户头像为系统默认
		int result = userDao.insertUser(email,name,pass);
		if(result>0){
			return true;	
		} else{
			return false;
		}
		
	}
	@Override
	public boolean verifyEmail(String email) {
		UserBO bo = userDao.queryUserByEmail(email);
		if(bo!=null&&bo.getId()>0) {
			return true;
		}else {
			return false;
		}
	}
	@Override
	public String userLogin(HttpServletRequest req, HttpServletResponse resp) {
		String email = req.getParameter("email");
		String pass = req.getParameter("pass");
		pass = StringUtil.passEncrypt(pass);
		UserBO bo = userDao.queryUser(email,pass);
		if(bo!=null&&bo.getId()>0) {
			//更新登录日期
			int time_result = userDao.updateLoginTime(email);
			if(time_result<1) {
				return "system_error";
			}else {
				//更新session
				UserUtil.addLoginUserSession(req, bo);
				return "success";
			}
		}else {
			return "pass_error";
		}
	}
	@Override
	public UserBO getUserByID(String id) {
		return userDao.queryUserByID(id);
	}
	@Override
	public boolean leaveMsg(HttpServletRequest req, HttpServletResponse resp) {
		UserBO visitedUser = UserUtil.getVisitedUser(req, resp);
		String type = req.getParameter("type");
		String msg = req.getParameter("msg");
		String email = "";
		String name = "";
		if("login".equals(type)) {
			UserBO loginUser = UserUtil.getLoginUser(req, resp);
			email = loginUser.getEmail();
			name = loginUser.getName();
		}else if("logout".equals(type)) {
			email = req.getParameter("email");
			name = req.getParameter("name");
		}else {
			return false;
		}
		int num = userDao.insertLeaveMsg(email,name,msg,type,visitedUser.getId());
		if(num<1) {
			return false;
		}else {
		}
		return true;
	}
	
	@Override
	public boolean updateInfo(HttpServletRequest req, HttpServletResponse resp) {
		
		String name = req.getParameter("name");
		String rel_name = req.getParameter("relname");
		String gender = req.getParameter("gender");
		String homeProvince = req.getParameter("homeprovince");
		String birthday = req.getParameter("birth_str");
		String hobby = req.getParameter("hobby");
		String contactStr = req.getParameter("contact_str");
		String publicStr = req.getParameter("public_str");

		UserBO user = UserUtil.getLoginUser(req, resp);
		UserInfoBO info= userDao.queryUserInfoByUserID(user.getId());
		/*
		 * 昵称改变，更新user表
		 */
		if(!name.equals(user.getName())){
			userDao.updateUserName(name,user.getId());
			//更新session信息
			user.setName(name);
			UserUtil.addLoginUserSession(req, user);
		}
		int result = 0;
		if(info!=null&&info.getId()>0) {
			//更新
			result = userDao.updateUserInfo(user.getId(),rel_name,gender,homeProvince,birthday,hobby,contactStr,publicStr);
		}else {
			//插入
			result = userDao.insertUserInfo(user.getId(),rel_name,gender,homeProvince,birthday,hobby,contactStr,publicStr);
		}
		if(result<1) {
			return false;
		}else{
			return true;
		}
	}
	@Override
	public UserInfoBO getUserInfoByID(String userId) {
		return userDao.queryUserInfoByUserID(Long.parseLong(userId));
	}
	@Override
	public String updatePhoto(String id,Long userId) {
		String photoPath = "";
		if("anime".equals(id.split("_")[0])) {
			photoPath = "/img/head/default/anime/"+id.split("_")[1]+".jpg"; 
		}
		if("animal".equals(id.split("_")[0])) {
			photoPath = "/img/head/default/animal/"+id.split("_")[1]+".jpg"; 
		}
		boolean result = userDao.updatePhoto(photoPath,userId);
		if(result) {
			return photoPath;
		}else {
			return "fail";
		}
	}
	
}
