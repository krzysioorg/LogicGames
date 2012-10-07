package org.krzysio.games.filters;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

/**
 * @author krzysztof
 *
 */
public class UsernameCookieFilter extends HttpServletFilter {
	
	public static final String USERNAME_COOKIE = "username";

	@Override
	protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
		Cookie[] cookies = request.getCookies();
		String username = addCookieIfMissing(USERNAME_COOKIE, cookies, response, "Anonymous");
		
		request.setAttribute(USERNAME_COOKIE, username);
		
		chain.doFilter(request, response);
	}
	
	private String addCookieIfMissing(String cookieName, Cookie[] currentCookies, HttpServletResponse response, String defultValue) {
		String value = null;
		
		if (currentCookies != null && currentCookies.length > 0) {
			for (Cookie cookie : currentCookies) {
				if (cookie.getName().equals(cookieName)) {
					value = cookie.getValue();
					break;
				}
			}
		}
		
		if (StringUtils.isEmpty(value)) {
			value = defultValue;
			response.addCookie(new Cookie(USERNAME_COOKIE, value));
		}
		
		return value;
		
	}

}
