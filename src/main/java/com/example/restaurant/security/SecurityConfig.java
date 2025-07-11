package com.example.restaurant.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.example.restaurant.service.CustomOAuth2Service;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	private CustomOAuth2Service customOAuth2Service;
	public SecurityConfig(CustomOAuth2Service customOAuth2Service) {
		this.customOAuth2Service = customOAuth2Service;
	}

	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception{
		
		httpSecurity.csrf(csrfConfigurer -> csrfConfigurer.disable());
		
		// 인가설정
		httpSecurity.authorizeHttpRequests(matcherRegistry -> 
				matcherRegistry.requestMatchers("/", "/WEB-INF/view/**", "/login", "/oauth2").permitAll()
								.anyRequest().authenticated());
		
		// 로그인
		httpSecurity.formLogin(formLoginConfigurer -> formLoginConfigurer.disable());
		
		// OAuth2 로그인 설정
		// GET으로 /login요청이 오면 OAuth2 기본설정(로그인)
		// httpSecurity.oauth2Login(Customizer.withDefaults());
		httpSecurity.oauth2Login(loginConfigurer  -> 
						loginConfigurer.loginPage("/login")
						.userInfoEndpoint(a -> a.userService(customOAuth2Service)));
		
		return httpSecurity.build();
	}
}
