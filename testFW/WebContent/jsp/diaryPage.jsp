<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.testFW.bo.UserBO"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String fun = (String) request.getAttribute("fun");
	if (fun == null)
		fun = "";
	UserBO user = (UserBO)request.getAttribute("loginUser");
	boolean hasLogin = false;
	if(user==null) {
		user = new UserBO(); 
	}else{
		hasLogin = true;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/css/common.css" rel="stylesheet" type="text/css" />
<link href="/css/diary.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"></script>
	<!-- snippet js and css-->
	<!-- aToolTip css -->
<link type="text/css"
	href="<%=request.getContextPath()%>/css/plugin/atooltip/atooltip.css"
	rel="stylesheet" media="screen" />
<!-- aToolTip js -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/plugin/atooltip/jquery.atooltip.js"></script>
<script language="javascript" type="text/javascript">
	$(function() {
		$('.small_search').click(function() {
			if (this.value == this.defaultValue) {
				this.value = '';
			}
		});
		$('.small_search').blur(function() {
			if (this.value == '') {
				this.value = this.defaultValue;
			}
		});
		$('a.fixedTip').aToolTip();
		$('input.fixedTip').aToolTip();
	});
</script>
<title>日志</title>
</head>
<body>
	<div class="wrap">
		<div class="header">
			<div class="search_box">
				<form method="post" id="sForm"
					action="<%=request.getContextPath()%>/action/system/search">
					<input name="s" id="s" value="站内搜索" class="small_search fixedTip"
						type="text"  title="输入内容后，敲击回车可以在全站内搜索相关信息"/>
				</form>
			</div>
			<h1>
				<a href="<%=request.getContextPath()%>/action/system/mainpage"
					title="testFW Logo"><img
					src="<%=request.getContextPath()%>/img/easyfw.png"
					alt="TestFW Logo" /> </a>
			</h1>
			<p>
				不因感情,而影响行动,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					不因得失,而惧怕前行. 
			</p>
		</div>
		<div class="container">
			<div class="sidebar">
				<ul class="side_nav">
					<li <%if ("mainpage".equals(fun)) {%> class="active" <%}%>><a
						class="fixedTip"
						href="http://www.testFW.com/action/system/mainpage"
						title="查看个人主页信息" id="mainpage">主页</a></li>
					<li <%if ("diary".equals(fun)) {%> class="active" <%}%>><a
						class="fixedTip" href="http://www.testFW.com/action/system/diary/"
						title="查看日志" id="diary">日志</a></li>
					<li <%if ("picture".equals(fun)) {%> class="active" <%}%>><a
						class="fixedTip"
						href="http://www.testFW.com/action/system/picture" title="查看图册信息"
						id="picture">图册</a></li>
					<li <%if ("aboutus".equals(fun)) {%> class="active" <%}%>><a
						class="fixedTip"
						href="http://www.testFW.com/action/system/aboutus" title="关于我以及本站"
						id="aboutus">about</a></li>
				</ul>
			</div>
			<div class="main_wrap">
				<div class="main">
					<div class="top_bar"></div>
					<div class="group" id="paging">
						<a title="Page 1" href="#">登录</a>
						<a title="Page 1" href="#">留言</a>
					</div>
					<div class="articles">
						<div class="artical" id="post-1">
							<div class="art-cats">
								<ul>
									<li class="blogNum"><a title="测试博文" href="#">1</a>
									</li>
									<li class="tag"><a title="标签1" href="#">标签one</a>
									</li>
									<li class="tag"><a title="标签2" href="#">标签two</a>
									</li>
								</ul>
							</div>
							<div class="art-header">
								<h1 class="art-title">
									<a title="测试博文标题" href="#">测试博文标题test blog-title</a>
								</h1>
								<p class="comment-count">
									<a title="测试博文回复数" href="#">3</a>
								</p>
								<div class="art-meta">
									Posted on <a title="12:10 pm" href="#">December 14, 2012</a><span
										class="byline"> by <span class="author"><a
											title="查看他发布的所有博文" href="#">作者1</a> </span> </span>
								</div>
							</div>
							<div class="art-content">
							<!-- 
								<div style="width: 610px" class="" id="attachment_42042">
									<a href="#"><img width="600" height="240"
										src="http://cdn4.wpcandy.com/wp-content/uploads/2012/12/bbpress-jennifer-m-dodd.jpg">
									</a>
									<p class="wp-caption-text">Photo credit: Jennifer Dodd</p>
								</div>
							 -->
								<p>测试博文内容测试博文内容测试博文内容测试博文内容测试博文内容测试博文内容 Jennifer M. Dodd
									joined the bbPress core commit team this week after
									contributing to the project since the plugin version of bbPress
									was introduced. bbPress lead John James Jacoby said,
								</p>
								<p>
									<a class="more-link"
										href="#">查看全文
										<span>↓</span>
									</a>
								</p>
							</div>
						</div>
						<div class="artical" id="post-1">
							<div class="art-cats">
								<ul>
									<li class="blogNum"><a title="测试博文" href="#">2</a>
									</li>
									<li class="tag"><a title="标签1" href="#">标签one</a>
									</li>
									<li class="tag"><a title="标签2" href="#">标签two</a>
									</li>
									<li class="tag"><a title="标签2" href="#">标签two</a>
									</li>
								</ul>
							</div>
							<div class="art-header">
								<h1 class="art-title">
									<a title="测试博文标题" href="#">测试博文标题test blog-title</a>
								</h1>
								<p class="comment-count">
									<a title="测试博文回复数" href="#">3</a>
								</p>
								<div class="art-meta">
									Posted on <a title="12:10 pm" href="#">December 14, 2012</a><span
										class="byline"> by <span class="author"><a
											title="查看他发布的所有博文" href="#">作者1</a> </span> </span>
								</div>
							</div>
							<div class="art-content">
							<!-- 
								<div style="width: 610px" class="" id="attachment_42042">
									<a href="#"><img width="600" height="240"
										src="http://cdn4.wpcandy.com/wp-content/uploads/2012/12/bbpress-jennifer-m-dodd.jpg">
									</a>
									<p class="wp-caption-text">Photo credit: Jennifer Dodd</p>
								</div>
							 -->
								<p>测试博文内容测试博文内容测试博文内容测试博文内容测试博文内容测试博文内容 Jennifer M. Dodd
									joined the bbPress core commit team this week after
									contributing to the project since the plugin version of bbPress
									was introduced. bbPress lead John James Jacoby said,
								</p>
								<p>
									<a class="more-link"
										href="#">查看全文
										<span>↓</span>
									</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="section_wrap more_padding">
					<h3>
						<strong>1989</strong> Keep learning &amp; Remain Modest.
					</h3>
					<small>&copy; Copyright 2012 TestFW. All rights
						reserved.  Designed by <a target="_blank"
						href="http://www.testFW.com/action/user/1">Kalor</a>
					</small><br><br>
				</div>
			</div>
		</div>
	</div>
</body>
</html>