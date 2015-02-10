# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

# TwitterAPIのドキュメントURL
apidoc_url = 'https://dev.twitter.com/rest/public'

api_list = []

charset = nil
html = open(apidoc_url) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

# htmlをパース(解析)してオブジェクトを生成
doc = Nokogiri::HTML.parse(html, nil, charset)



sidemenu = doc.xpath('//div[@class="SystemBlock"]')[0].xpath('//ul[@class="menu"]')



sidemenu.xpath('//a').each do |apiname|

	if apiname.inner_text.index("GET") != nil
		tempurl=apiname["href"]
		api_list.push({ 
			:url =>  tempurl, 
			:example => get_example(tempurl) })
		#p apiname.inner_text
		#p apiname["href"]
	end
end

p api_list

def get_example(url)
	return ""
end