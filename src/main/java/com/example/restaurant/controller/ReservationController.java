package com.example.restaurant.controller;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.restaurant.dto.ReservationDto;
import com.example.restaurant.dto.RoomDto;
import com.example.restaurant.service.ReservationService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReservationController {
	private ReservationService reservationService;
	public ReservationController(ReservationService reservationService) {
		this.reservationService = reservationService;
	}

	@GetMapping("/roomList")
	public String roomList(Model model) {
		List<RoomDto> roomList = reservationService.selectRoom();
		model.addAttribute("roomList", roomList);
		return "roomList";
	}
	
	@GetMapping("/reserve")
	public String reserve(Model model,
				@RequestParam int roomNo,
				@RequestParam String date,
				@RequestParam String time) {
		// log.info(roomNo + ""); log.info(date); log.info(time);

		// 이름 받아오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
			Map<String, Object> attributes = oAuth2User.getAttributes();

			String name = "";

			if (attributes.containsKey("response")) {
			    // Naver
			    Map<String, Object> response = (Map<String, Object>) attributes.get("response");
			    name = (String) response.get("name");
			} else if (attributes.containsKey("properties")) {
			    // Kakao
			    Map<String, Object> properties = (Map<String, Object>) attributes.get("properties");
			    name = (String) properties.get("nickname");
			} else {
			    // Google
			    name = (String) attributes.get("name");
			}
	    
		model.addAttribute("name", name);
		model.addAttribute("roomNo", roomNo);
		model.addAttribute("date", date);
		model.addAttribute("time", time);
		return "reserve";
	}
	
	@PostMapping("/reserve")
	public String reserve(ReservationDto reservationDto) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		// authentication(인증된 UserDetails DTO getName)
		String loginUsername = authentication.getName();
		
		// authentication(인증된 UserDetails DTO role)
		Collection<? extends GrantedAuthority> roleList = authentication.getAuthorities();
		// 순서가 있는(foreach가능한) 컬렉션으로 변경
		Iterator<? extends GrantedAuthority> iterator = roleList.iterator(); // 이터레이터 패턴
		
		GrantedAuthority gh = null;
		/* 하나의 role만 설정된 상태이이게 반복문을 사용할 필요는 없다
		while ((gh = iterator.next()) != null) {
			String role = gh.getAuthority(); // 사용자의 role
		}
		*/
		String loginRole = "";
		if ((gh = iterator.next()) != null) {
			loginRole = gh.getAuthority().replace("ROLE_", "").toLowerCase();
		}
		
		//log.info(loginUsername);
		//log.info(loginRole);
		reservationDto.setReservationId(loginUsername);
		reservationDto.setProvider(loginRole);
		log.info(reservationDto.toString());
		
		reservationService.reserveRoom(reservationDto);
		return "redirect:/";
	}
	
	@GetMapping("/myReserve")
	public String myReserve(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String loginUsername = authentication.getName(); // 전화번호 또는 이메일 (naver 등)
	    log.info(loginUsername);
	    
	    List<ReservationDto> myList = reservationService.myReservations(loginUsername);
	    model.addAttribute("myReservations", myList);
	    log.info(myList.toString());
	    
		return "myReserve";
	}
	
	@GetMapping("/cancelReserve")
	public String cancelReserve(@RequestParam int reservationNo) {
		reservationService.cancelReserve(reservationNo);
		return "redirect:";
	}
}
