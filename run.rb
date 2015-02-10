# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

require 'fileutils'


def make_mock(list)
	p list 
end

def get_example(url)
	charset = nil
	html = open(url) do |f|
		charset = f.charset # 文字種別を取得
		f.read # htmlを読み込んで変数htmlに渡す
	end	

	# htmlをパース(解析)してオブジェクトを生成
	doc = Nokogiri::HTML.parse(html, nil, charset)


	examples = doc.xpath('//pre[@class="brush: jscript"]')
	#syntaxhighlighter nogutter  jscript  

	#puts examples[0].inner_text
	if !!examples[0]
		return examples[0].inner_text
	else
		return ""
	end
end

def main
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
				:url =>  "https://dev.twitter.com" + tempurl,
				:directory => "api" + tempurl,
				:example => get_example("https://dev.twitter.com" + tempurl) })
			#p apiname.inner_text
			#p apiname["href"]
		end
	end

	make_mock(api_list)
end


main