# Gravitee OAuth2 Server

OAuth2 Authorization Server based on Spring Security OAuth2

This is a minimal Authorization server based on Spring Security OAuth2 to validate security scenarios upon Gravitee Gateway API and Gravitee Gateway WebUI.

## Building

```
$ git clone https://github.com/gravitee-io/gravitee-oauth2-server.git
$ cd gravitee-oauth2-server
$ mvn jetty:run
...
<app starts and listens on port 8080>
```

## Get Started

### Get your tokens

```
Client Credentials Grant Type :

=============== =================================================
Request         POST /oauth/token
Request Body    grant_type=client_credentials&client_id=test&client_secret=test
Response Codes  200 OK
Response Body   ::

                  {
                      "access_token": "ecfe59e8-2983-4919-a44a-039766ed1c45",
                      "token_type": "bearer",
                      "expires_in": 43199,
                      "scope": "read write"
                  }

=============== =================================================

Resource Owner Password Grant Type :

=============== =================================================
Request         POST /oauth/token
Request Body    grant_type=password&client_id=test&client_secret=test&username=user&password=password
Response Codes  200 OK
Response Body   ::

                  {
                      "access_token": "46539a6f-67f0-4bcb-bdef-89e3794825f5",
                      "token_type": "bearer",
                      "refresh_token": "8c8d7232-9523-4838-85f7-14cb3aaa174c",
                      "expires_in": 43199,
                      "scope": "read write"
                  }

=============== =================================================

Refresh Token Grant Type :

=============== =================================================

Request         POST /oauth/token
Request Body    grant_type=refresh_token&client_id=test&client_secret=test&refresh_token=8c8d7232-9523-4838-85f7-14cb3aaa174c
Response Codes  200 OK
Response Body   ::

                 {
				    "access_token": "7ad8f410-d9d4-4106-b8c2-13cc48c0269d",
				    "token_type": "bearer",
				    "refresh_token": "8c8d7232-9523-4838-85f7-14cb3aaa174c",
				    "expires_in": 43200,
				    "scope": "read write"
				 }

=============== =================================================

Authorization Code (response type : code) Flow :

=============== =================================================

1) Get the authorization code

Request			GET /oauth/authorize
Request Body    response_type=code&client_id=test&redirect_uri=http://localhost:8080/yourapp
				# Submit the login form with an authorized user
Response Code	302 Found
Redirect to 	http://localhost:8080/yourapp?code=7m6TKQ
					
2) Exchange your code against the access token

Request			POST /oauth/token
Request Body	grant_type=authorization_code&client_id=test&code=7m6TKQ&redirect_uri=http://localhost:8080/yourapp
Response Codes  200 OK
Response Body   ::

                 {
				    "access_token": "7ad8f410-d9d4-4106-b8c2-13cc48c0269d",
				    "token_type": "bearer",
				    "refresh_token": "8c8d7232-9523-4838-85f7-14cb3aaa174c",
				    "expires_in": 43200,
				    "scope": "read write"
				 }
				 
=============== =================================================

Authorization Code (response type : token) Flow :

=============== =================================================

Request			GET /oauth/authorize
Request Body    response_type=token&client_id=test&redirect_uri=http://localhost:8080/yourapp
				# Submit the login form with an authorized user
Response Code	302 Found
Redirect to 	http://localhost:8080/yourapp#access_token=7ad8f410-d9d4-4106-b8c2-13cc48c0269d&token_type=bearer&expires_in=42634&scope=read%20write
```

### OAuth2 Token Validation Service

An endpoint that allows a resource server to validate an access token. The application client is authenticated via basic auth for this call.

```
Request			POST /oauth/check_token
Request Body	token=7ad8f410-d9d4-4106-b8c2-13cc48c0269d
Request Headers Authorization: Basic dGVzdDp0ZXN0 => stands for Base64.encode(client_id:client_secret)
				Content-Type: application/x-www-form-encoded
Response Codes  200 OK
Response Body   ::
                {
				    "exp": 1426391913,
				    "user_name": "user",
				    "scope": [
				        "read",
				        "write"
				    ],
				    "authorities": [
				        "ROLE_USER"
				    ],
				    "client_id": "test"
				}
```

### OpenID User Info Endpoint

An OAuth2 protected resource and an OpenID Connect endpoint. Given an appropriate access_token, returns information about a user.

```
Request	        GET /userinfo/check_token
Request Headers Authorization: Bearer <acces_token>

Response Codes  200 OK
Response Body   ::
               {
				    "password": null,
				    "username": "user",
				    "authorities": [
				        {
				            "authority": "ROLE_USER"
				        }
				    ],
				    "accountNonExpired": true,
				    "accountNonLocked": true,
				    "credentialsNonExpired": true,
				    "enabled": true
				}
```
