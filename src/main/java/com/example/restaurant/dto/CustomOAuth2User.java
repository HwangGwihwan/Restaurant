package com.example.restaurant.dto;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

public class CustomOAuth2User implements OAuth2User{ // OAuth2UserService 반환할 DTO

	private Map<String, Object> attributes; // service attributes값을 주입(setter, constructor, ...)
	private String role;
	private String registrationId;
	
	public CustomOAuth2User(Map<String, Object> attributes, String role, String registrationId) {
		this.attributes = attributes;
		this.role = role;
		this.registrationId = registrationId;
	}

	@Override
	public Map<String, Object> getAttributes() {
		return this.attributes;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> roleList = new ArrayList<GrantedAuthority>();
		//roleList.add(() -> this.role);
		roleList.add(new GrantedAuthority() {
			@Override
			public String getAuthority() {
				return CustomOAuth2User.this.role;
			}
		});
		
		return roleList;
	}

	@Override
	public String getName() { // attributes속성중에 유니크한값을 사용 - email or mobile
		if ("naver".equalsIgnoreCase(registrationId)) {
            Map<String, Object> response = (Map<String, Object>) attributes.get("response");
            return (String) response.get("mobile"); // 또는 "email"
        } else if ("kakao".equalsIgnoreCase(registrationId)) {
            Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
            Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
            return (String) profile.get("nickname");
        } else if ("google".equalsIgnoreCase(registrationId)) {
            return (String) attributes.get("email");
        } else {
            return "unknown";
        }
	}
}

