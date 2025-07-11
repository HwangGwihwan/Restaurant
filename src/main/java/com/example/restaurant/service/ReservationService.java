package com.example.restaurant.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.restaurant.dto.ReservationDto;
import com.example.restaurant.dto.RoomDto;
import com.example.restaurant.mapper.ReservationMapper;


@Service
public class ReservationService {
	private ReservationMapper reservationMapper;	
	public ReservationService(ReservationMapper reservationMapper) {
		this.reservationMapper = reservationMapper;
	}

	// 전체 룸 조회
	public List<RoomDto> selectRoom() {
		return reservationMapper.selectRoom();
	}
	
	// 예약 가능 룸 조회
	public List<RoomDto> emptyRoom(String date, String time) {
		return reservationMapper.emptyRoom(date, time);
	}
	
	// 룸마다 최대 정원 조회
	public int roomLimit(int roomNo) {
		return reservationMapper.roomLimit(roomNo);
	}
	
	// 룸 예약
	public int reserveRoom(ReservationDto reservationDto) {
		return reservationMapper.reserveRoom(reservationDto);
	}
	
	// 내 예약조회
	public List<ReservationDto> myReservations(String reservationId) {
	    return reservationMapper.findByReservationId(reservationId);
	}
}
