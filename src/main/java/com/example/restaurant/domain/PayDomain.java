package com.example.restaurant.domain;

import lombok.Data;

@Data
public class PayDomain {
	private int payNo;
	private int reservationNo;
	private int amount;
	private String payMethod;
	private String createdate;
}
