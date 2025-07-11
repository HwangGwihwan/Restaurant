package com.example.restaurant.controller.rest;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.example.restaurant.dto.RoomDto;
import com.example.restaurant.service.ReservationService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class Rest {
	private ReservationService reservationService;
	public Rest(ReservationService reservationService) {
		this.reservationService = reservationService;
	}

	@GetMapping("/checkRoom/{date}/{time}")
	public List<RoomDto> checkRoom(@PathVariable String date,
				@PathVariable String time) {
		
		List<RoomDto> roomList = reservationService.emptyRoom(date, time);
		//log.info(roomList.toString());
		return roomList;
	}
	
	@GetMapping("/roomLimit/{roomNo}")
	public int roomLimt(@PathVariable int roomNo) {
		return reservationService.roomLimit(roomNo);
	}
}
