local http  = require "resty.lua_resty_http.http"

local ngx_escape_uri = ngx.escape_uri

local cookie_uri     = ngx_escape_uri(ngx.var.cookie_uri)
local http_referer   = ngx_escape_uri(ngx.var.http_referer)

-- write your google_anaytics UA-xxxxxxxxx-1 to here
-- local tid    = "UA-111111111-1"
local tid       = 
local post_body = "v=1&t=pageview&tid=" .. tid .. "&uip=" .. ngx.var.remote_addr .. "&cid=" .. ngx.var.cookie_cid .. "&dp=" .. cookie_uri .. "&dr=" .. http_referer .. "&z=" .. ngx.var.msec

local http_new = http.new()
http_new:set_timeout(3000)
http_new:request_uri("https://www.google-analytics.com/collect", {
	version    = 1.1,
	method     = "POST",
	headers    = { ["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8", ["User-Agent"] = ngx.var.http_user_agent },
	body       = post_body,
	ssl_verify = false
})
