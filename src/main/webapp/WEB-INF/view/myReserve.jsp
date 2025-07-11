<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f5f7fa;
        padding: 40px;
        color: #333;
    }

    h1 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
    }

    p {
        text-align: center;
        font-size: 18px;
        color: #777;
    }

    table {
        margin: 0 auto;
        border-collapse: collapse;
        width: 80%;
        background-color: #fff;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        overflow: hidden;
    }

    th, td {
        padding: 14px 18px;
        text-align: center;
    }

    thead {
        background-color: #3498db;
        color: white;
    }

    tbody tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tbody tr:hover {
        background-color: #dceefc;
    }

    th {
        font-weight: 600;
        font-size: 16px;
    }

    td {
        font-size: 15px;
    }
</style>
</head>
<body>
	<h1>내 예약내역</h1>
	
	<c:if test="${empty myReservations}">
	    <p>예약 내역이 없습니다.</p>
	</c:if>
	
	<c:if test="${not empty myReservations}">
	    <table border="1">
	        <thead>
	        <tr>
	            <th>방 번호</th>
	            <th>예약 날짜</th>
	            <th>시간</th>
	            <th>인원수</th>
	            <th>플랫폼</th>
	        </tr>
	        </thead>
	        <tbody>
	        <c:forEach var="r" items="${myReservations}">
	            <tr>
	                <td>${r.roomNo}</td>
	                <td>${r.reservationDate}</td>
	                <td>${r.reservationOption}</td>
	                <td>${r.reservationCount}</td>
	                <td>${r.provider}</td>
	            </tr>
	        </c:forEach>
	        </tbody>
	    </table>
	</c:if>


</body>
</html>