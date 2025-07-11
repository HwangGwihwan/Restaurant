package com.example.restaurant.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.restaurant.dto.ReservationDto;
import com.example.restaurant.dto.RoomDto;

@Mapper
public interface ReservationMapper {
	// 전체 룸 조회
	List<RoomDto> selectRoom();
	
	// 예약 가능 룸 조회
	List<RoomDto> emptyRoom(String date, String time);
	
	// 룸마다 최대 정원 조회
	int roomLimit(int roomNo);
	
	// 룸 예약
	int reserveRoom(ReservationDto reservationDto);
	
	// 내 예약조회
	List<ReservationDto> findByReservationId(String reservationId);
}
