<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 40px;
        color: #333;
    }

    h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
    }

    .welcome-box {
        background-color: #ffffff;
        padding: 20px;
        margin-top: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .welcome-box a {
        display: inline-block;
        margin: 10px 0;
        text-decoration: none;
        background-color: #3498db;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    .welcome-box a:hover {
        background-color: #2980b9;
    }

    .login-link {
        background-color: #2ecc71;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    .login-link:hover {
        background-color: #27ae60;
    }
</style>
</head>
<body>
	<h1>Home</h1>
	
	<c:if test="${loginUsername == 'anonymousUser'}">
		<a href="/login">로그인</a>
	</c:if>
	
	<c:if test="${loginUsername != 'anonymousUser'}">
		<div class="welcome-box">
	        <p><strong>${loginUsername}</strong> (${loginRole})님 반갑습니다. (창을 닫으면 로그아웃됩니다)</p>
	        <a href="/roomList">식당 테이블 예약</a><br>
	        <a href="/myReserve">내 예약내역 보기</a>
	    </div>
	</c:if>
	
</body>
</html>