<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식당 테이블 예약</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 30px;
        color: #333;
    }

    h1 {
        color: #2c3e50;
        margin-bottom: 20px;
    }

    input[type="date"], select {
        padding: 8px 12px;
        font-size: 16px;
        margin-right: 10px;
        border: 1px solid #ccc;
        border-radius: 6px;
    }

    #tableContainer {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        margin-top: 30px;
    }

    .table-box {
        width: 180px;
        min-height: 130px;
        padding: 15px;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
        transition: transform 0.2s ease, box-shadow 0.3s ease;
        text-align: center;
        font-weight: 500;
        font-size: 16px;
        line-height: 1.6;
        background-color: #ddd;
        cursor: default;
    }

    .table-box:hover {
        transform: scale(1.03);
    }

    .available {
        background-color: #2ecc71;
        color: #fff;
        cursor: pointer;
    }

    .available:hover {
        background-color: #27ae60;
    }

    .unavailable {
        background-color: #e74c3c;
        color: #fff;
        cursor: not-allowed;
    }
</style>

<script>
$(function () {
    function updateTables() {
        const date = $('#date').val();
        const time = $('#time').val();

        if (!date || !time) return;
        
        
        $.ajax({
            url: "/checkRoom/" + date + "/" + time,
            type: 'get',
            dataType: 'json',
            success: function (roomList) {
                // 초기화
                $('.table-box').removeClass('available unavailable');
                $('.table-box').off('click');  // 클릭 이벤트 제거
                $('.table-box').empty();       // 내용 비우기

                roomList.forEach(function (room) {
                    const box = $('#table-' + room.roomNo);

                    // 기본 내용
                    box.append(room.roomName + "<br>");
                    box.append("최대 정원: " + room.roomLimit + "<br>");

                    if (room.reservationStatus === 1) {
                        box.addClass('unavailable');
                        box.append("예약 불가");
                    } else {
                        box.addClass('available');
                        box.append("예약 가능");

                        // 클릭 이벤트 등록
                        box.on('click', function () {
                            window.location.href = "/reserve?roomNo=" + room.roomNo + "&date=" + date + "&time=" + time;
                        });
                    }
                });
            },
            error: function () {
                alert("예약 정보를 가져오는 데 실패했습니다.");
            }
        });
    }

    // 날짜 또는 시간 변경 시 실행
    $('#date, #time').on('change', updateTables);

    // 페이지 로드 시 초기 상태(날짜 선택 전)는 모두 초록색 예약 가능 표시
    $('.table-box').each(function () {
        const box = $(this);
        box.addClass('available');
        box.append("예약 가능");
        box.css('cursor', 'pointer');
        box.on('click', function () {
            alert('예약 날짜와 시간을 선택해주세요.');
        });
    });
});
</script>
</head>
<body>
    <h1>식당 테이블 예약</h1>

    예약 날짜 :
    <input type="date" id="date" name="date">

    시간대 :
    <select name="time" id="time">
        <option value="AM" selected>오전</option>
        <option value="PM">오후</option>
    </select>

    <div id="tableContainer" style="margin-top: 30px;">
        <c:forEach var="room" items="${roomList}">
            <div class="table-box" id="table-${room.roomNo}">
                ${room.roomName}<br>
                최대 정원: ${room.roomLimit}<br>
            </div>
        </c:forEach>
    </div>
</body>
</html>
