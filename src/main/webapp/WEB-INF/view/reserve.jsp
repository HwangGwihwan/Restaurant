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
        background-color: #f9fafc;
        padding: 40px;
        color: #333;
    }

    h1 {
        color: #2c3e50;
        text-align: center;
        margin-bottom: 30px;
    }

    form {
        max-width: 500px;
        margin: 0 auto;
        background-color: #fff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }

    label, br {
        display: block;
        margin-top: 15px;
        margin-bottom: 5px;
        font-weight: 600;
    }

    input[type="text"],
    input[type="date"],
    select {
        width: 100%;
        padding: 10px 12px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 6px;
        margin-bottom: 10px;
        box-sizing: border-box;
    }

    input[readonly] {
        background-color: #f0f0f0;
    }

    .time-options {
        margin-top: 5px;
        margin-bottom: 15px;
    }

    .time-options input[type="radio"] {
        margin-right: 5px;
    }

    button {
        width: 100%;
        padding: 12px;
        font-size: 16px;
        background-color: #3498db;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-top: 20px;
    }

    button:hover {
        background-color: #2980b9;
    }

    select:invalid {
        color: #aaa;
    }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
$(function () {
    // 인원 선택 시 이벤트
    $('#reservationCount').on('change', function () {
        const selectedCount = parseInt($(this).val());
        const roomNo = $('input[name="roomNo"]').val();

        if (!selectedCount || !roomNo) return;

        // AJAX로 roomLimit 요청
        $.ajax({
            url: '/roomLimit/' + roomNo,
            type: 'get',
            success: function (roomLimit) {
                if (selectedCount > roomLimit) {
                    alert("최대 인원(" + roomLimit + "명)을 초과할 수 없습니다.");
                    $('#reservationCount').val(""); // 선택 초기화
                }
            },
            error: function () {
                alert("최대 인원을 확인할 수 없습니다. 다시 시도해주세요.");
            }
        });
    });
    
 	// 폼 제출 전 인원 수 확인
    $('form').on('submit', function (e) {
        const selectedCount = $('#reservationCount').val();

        if (!selectedCount) {
            alert("인원수를 선택해주세요.");
            e.preventDefault(); // 폼 전송 막기
        }
    });
});
</script>
</head>
<body>
	<h1>테이블 예약</h1>
	
	<form action="/reserve" method="post">
		<input type="hidden" name="roomNo" value="${roomNo}">

		이름 <br>
		<input type="text" id="name" value="${name}" readonly>
		<br>
		
		날짜 <br>
		<input type="date" id="date" name="reservationDate" value="${date}" readonly>
		<br>
		
		시간 <br>
		<input type="radio" name="time" value="AM"
			<c:if test="${time == 'AM'}">checked</c:if> disabled> 오전
	    &nbsp;&nbsp;
	    <input type="radio" name="time" value="PM"
	    	<c:if test="${time == 'PM'}">checked</c:if> disabled> 오후
	    <!-- 숨겨진 필드로 값 전송 -->
    	<input type="hidden" name="reservationOption" value="${time}">
	    <br>
	    
	    인원 수 <br>
	    <select name="reservationCount" id="reservationCount">
		    <option value="">선택하세요</option>
		    <c:forEach var="i" begin="1" end="6">
		        <option value="${i}" <c:if test="${personCount == i}">selected</c:if>>${i}명</option>
		    </c:forEach>
		</select>
		
		<br>
		<button type="submit">예약하기</button>
	</form>
	
</body>
</html>