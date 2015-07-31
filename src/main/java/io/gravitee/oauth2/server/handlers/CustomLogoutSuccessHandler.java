/*******************************************************************************
 * Copyright (C) 2015 The Gravitee team (http://gravitee.io)
 *  
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *  
 *         http://www.apache.org/licenses/LICENSE-2.0
 *  
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and limitations under the License.
 *******************************************************************************/
package io.gravitee.oauth2.server.handlers;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

/**
 * Same as {@link SimpleUrlLogoutSuccessHandler} but retrieve targetUrl form the request target_url parameter
 *
 * @author Titouan COMPIEGNE
 * 
 */
public class CustomLogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler{

	private static final String LOGOUT_URL_PARAMETER = "target_url";
	
	@Override
	protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response) {
		String logoutRedirectUrl = request.getParameter(LOGOUT_URL_PARAMETER);
		if (logoutRedirectUrl != null && !logoutRedirectUrl.isEmpty()) {
			setTargetUrlParameter(LOGOUT_URL_PARAMETER);
		}
		return super.determineTargetUrl(request, response);
	}
	
}
