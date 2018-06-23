Name
====
lua-resty-minami/google_analytics : Openresty library to build a google_analytics webserver


Table of Contents
=================
* [Name](#name)
* [Status](#status)
* [Description](#description)
* [Synopsis](#synopsis)
* [Author](#author)
* [Copyright and License](#copyright-and-license)
* [See Also](#see-also)
* [According](#according)


Status
======
This library is considered passed testing and may change without notice.

[Back to TOC](#table-of-contents)


Description
===========
This library requires a Openresty build, please take [here](https://sometimesnaive.org/article/71) as reference.

[Back to TOC](#table-of-contents)


Synopsis
========
```nginx
# nginx.conf

# library folder 'resty' dir
lua_package_path "/path/to/conf/?.lua;;";



# website.conf
location / {
    ...
    
    header_filter_by_lua_file /path/to/conf/headerfilter.lua;

    mirror                    /google_analytics;
    mirror_request_body       on;
}

location /google_analytics {
    internal;

    resolver 8.8.8.8 ipv6=off;
    resolver_timeout 10s;

    access_by_lua_file  /path/to/conf/access.lua;
    content_by_lua_file /path/to/conf/content.lua;
}
```

```lua
-- content.lua

-- write your google_anaytics UA-xxxxxxxxx-1 to here
-- local tid    = "UA-111111111-1"
local tid       = 
local post_body = "v=1&t=pageview&tid=" .. tid .. "&uip=" .. ngx.var.remote_addr .. "&cid=" .. ngx.var.cookie_cid .. "&dp=" .. cookie_uri .. "&dr=" .. http_referer .. "&z=" .. ngx.var.msec
```

[Back to TOC](#table-of-contents)


Author
======
Minami (Nanqinlang) (南琴浪) <https://sometimesnaive.org>

[Back to TOC](#table-of-contents)


Copyright and License
=====================
personal work, for non-profit, Copyright (C) 2018 All rights reserved.

This library's License: GPL v3.

[Back to TOC](#table-of-contents)


See Also
========
* the ngx_lua module: http://wiki.nginx.org/HttpLuaModule

[Back to TOC](#table-of-contents)


According
========
https://sometimesnaive.org/article/77
