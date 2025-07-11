package com.example.restaurant.dto;

import lombok.Data;

@Data
public class ReservationDto {
	private int reservationNo;
	private int roomNo;
	private String reservationDate;
	private String reservationOption;
	private String reservationId;
	private int reservationCount;
	private String provider;
	private String createdate;
	private String udpatedate;
}
