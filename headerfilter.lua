require "resty.lua_resty_core.regex"
require "resty.lua_resty_core.response"
local userid = require "resty.lua_resty_minami_ga.userid"


local cid = nil
local ngx_var_cookie_cid = ngx.var.cookie_cid
if (ngx_var_cookie_cid == nil) then
	--generate cid
	cid = userid.generate()
	--add cookie
	--ngx.header["Set-Cookie"] = {"cid=" .. cid}
end

--check: request_filename exists && http_user_agent not spider
local request_filename = ".../" .. ngx.var.uri
local file = io.open(request_filename, "r")
if (file and ngx.re.find(ngx.var.http_user_agent, "UptimeRobot|qihoobot|Baidu|Baiduspider|Baiduspider-image|Baiduspider-video|Baiduspider-news|Baiduspider-favo|Baiduspider-cpro|Baiduspider-ads|Baiduboxapp|YisouSpider|EasouSpider|YodaoBot|YoudaoBot|Sosospider|Sogou|Bingbot|BingPreview|Yahoo|Yahoo!|yahoo-mmcrawler|yahoo-blogs|DuckDuckBot|YandexBot|Slurp|ia_archiver|Tomato|FeedDemon|JikeSpider|Indy|Nuhkbot|Alexabot|AskTbFXTV|AhrefsBot|CrawlDaddy|Java|Feedly|UniversalFeedParser|ApacheBench|MSNBot|Swiftbot|ZmEuoBot|jaunty|Python-urllib|lightDeckReports|YYSpider|DigExt|MJ12bot|heritrix|Ezooms|Teoma|twiceler|Scrubby|Robozilla|Gigabot|psbot|Exabot|facebot|facebookexternalhit|Scrapy|HttpClient|Curl|Wget|Idm|Aria2|Axel|Thunder|Youtube-dl|Movgrab|rtorrent|ctorrent|Transmission-cli|vuze", "jo") == nil) then
	if (cid ~= nil) then
		ngx.header["Set-Cookie"] = {"stats=" .. "1", "cid=" .. cid}
	else
		ngx.header["Set-Cookie"] = {"stats=" .. "1", "cid=" .. ngx_var_cookie_cid}
	end
end
