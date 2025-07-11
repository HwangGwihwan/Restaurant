package com.example.restaurant.domain;

import lombok.Data;

@Data
public class ReservationDomain {
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
