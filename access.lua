if (ngx.var.cookie_stats ~= "1") then
	return ngx.exit(ngx.HTTP_NO_CONTENT)
end
