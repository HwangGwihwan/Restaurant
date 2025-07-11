package com.example.restaurant.dto;

import lombok.Data;

@Data
public class RoomDto {
	private int roomNo;
	private String roomName;
	private int roomLimit;
	private int reservationStatus;
}
