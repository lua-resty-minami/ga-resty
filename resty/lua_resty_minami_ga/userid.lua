local _M={}


function _M.generate()
	--take the instant unix time as random
	require "resty.lua_resty_core.time"
	local ngx_updatetime = ngx.update_time
	ngx_updatetime()
	local ngx_time = ngx.time
	local str_random = ngx_time()

	--get md5
	require "resty.lua_resty_core.hash"
	local ngx_md5 = ngx.md5
	local str_md5 = ngx_md5(str_random)

	--generate uuid
	local string_sub = string.sub
	local str_sub = string_sub(str_md5, 1, 8) .. "-" .. string_sub(str_md5, 9, 12) .. "-" .. string_sub(str_md5, 13, 16) .. "-" .. string_sub(str_md5, 17, 20) .. "-" .. string_sub(str_md5, 21, 32)

	--return
	return str_sub
end


return _M
