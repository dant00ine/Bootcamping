namespace :bootcamps do

  desc "Scrape All Boostcamps from: https://www.coursereport.com/schools/"
  task get_all: :environment do

	require "open-uri"
	require "nokogiri"
	require 'json'

	url = "https://www.coursereport.com/schools"
	page = Nokogiri::HTML(open(url))

	# Max schools number
	# search_max = page.css("div#main-content h1 span").text
	# max_schools = search_max.split.first.to_i

	links  = []
	(1..30).each do |i|
		url_paging = url + "?page=#{i}"
		page = Nokogiri::HTML(open(url_paging))
		
		# Getting link titles
		link = page.css("div.school-header h3").each do |l|
			x = l.at_css('a')['href']
			x.slice! "/schools/"
	    	links << x
		end
	end

	# _____Main_____  
	titles 		 = []
	abouts 		 = []
	images 		 = []

	# ____Details___
	specs        = []
	locations    = []
	websites     = []
	emails       = []
	facebooks    = []
	twitters     = []

	# ___More info___
	more_object  = {}
	more_arr    = []


		counter = 0
	# Linking to Page
	links.each do |t|
	# 1.times do
		url_link = url + "/#{t}"
		# url_link = "https://www.coursereport.com/schools/coding-dojo"

		begin
			doc = open(url_link)
		rescue OpenURI::HTTPError => http_error
		    # http_error.message is the numeric code and text in a string 
		    status = http_error.io.status[0].to_i # => 3xx, 4xx, or 5xx
		    puts "Got a bad status code #{status}"
		end
		
		# **************** Main Content *****************
		@boot = Bootcamp.new

		page = Nokogiri::HTML(doc)
		# Title
		page.css("div.navigable.col-md-8 div.main-header.hide-on-mobile h1").each do |t|
			if t.text.length > 1
				# t = t.text
				@boot.title = t.text
			end
			# titles << t
			puts "#{counter +=1}: #{t.text}"
		end

		# About
		about_arr = []
		page.css("section.about div.expandable p").each do |about|
			
			if about.content
				about = about.content
			end
			about_arr << about
			# abouts << about_arr
		end
		@boot.about = about_arr.join(' ')

		# Images
		page.css("div.col-xs-12.visible-xs.visible-sm div.school-image").each do |pic|
			if pic.at_css("img")
				puts x = pic.at_css("img")['src']
				# images << x
				@boot.bimage_url = pic.at_css("img")['src']
			else
				puts "Image non-exist"
			end
		end

		# # ****************  DETAILS *****************
		# speciality  
		spec_arr = []
		page.css("ul.school-info li.school-tracks a").each do |spec|
			if spec.text
				spec_arr << spec.text
			end
		end
		# specs << spec_arr
		@boot.speciality = spec_arr.join(", ")

		# Locations
		loc_arr = []
		page.css("ul.school-info li.location a").each do |loc|
			if loc.text
				loc_arr << loc.text
			end
		end
		# locations << loc_arr
		@boot.location = loc_arr.join(', ')

		# website
		page.css("ul.school-info li.url").each do |web|
			if web.at_css("a")["itemprop"]
				websites << web.text
				@boot.website = web.text
			end
		end

		# email
		page.css("ul.school-info li.email").each do |email|
			if email.text
				# emails << email.text
				@boot.email = email.text
			end
		end

		# facebook
		page.css("ul.school-info li.facebook").each do |face|
			if face.at_css("a")["href"]
				# facebooks << face.at_css("a")["href"]
				@boot.facebook = face.at_css("a")["href"]
			end
		end

		# twitter
		page.css("ul.school-info li.twitter").each do |twit|
			if twit.at_css("a")["href"]
				# twitters << twit.at_css("a")["href"]
				@boot.twitter = twit.at_css("a")["href"]
			end
		end


		# **************** More Information *****************
		arr = []
		page.css("div#more-info div.panel-body p").each do |more|
			arr << more.text
			more_object = {
				:job_guarantee  	 => arr[0],
				:job_assistance 	 => arr[1],
				:apprenticeship      => arr[2],
				:accreditation  	 => arr[3],
				:post_grad_resources => arr[4],
				:housing             => arr[5],
				:visa_assistance     => arr[6]
			}
		end
			# more_arr << more_object
			puts JSON.pretty_generate(more_object)

		@boot.job_guarantee        = arr[0]
		@boot.job_assistance       = arr[1]
		@boot.apprenticeship  	   = arr[2]
		@boot.accreditation  	   = arr[3]
		@boot.post_grad_resources  = arr[4]
		@boot.housing       	   = arr[5]
		@boot.visa_assistance	   = arr[6]

		@boot.save
	end 

	# links.length.times do |i|
	# 3.times do |i|
	# 	boj = {
	# 		:title => titles[i],
	# 		:about => abouts[i].join(' '),
	# 		:image => images[i],
	# 		:spec  => specs[i].join(', '),
	# 		:loc   => locations[i].join(', '),
	# 		:web   => websites[i],
	# 		:email => emails[i],
	# 		:faceb => facebooks[i],
	# 		:twitt => twitters[i],
	# 		:job_g => more_info[i][:job_guarantee],
	# 		:job_a => more_info[i][:job_assistance],
	# 		:appr  => more_info[i][:apprenticeship],
	# 		:acc   => more_info[i][:accreditation],
	# 		:post  => more_info[i][:post_grad_resources],
	# 		:hous  => more_info[i][:housing],
	# 		:visa  => more_info[i][:visa_assistance]
	# 	} 
	# puts boj

		# @boot = Bootcamp.new
		# @boot.title 	 = titles[i]
		# @boot.about 	 = abouts[i].join(' ')
		# @boot.image_url  = images[i] #if images[i].present?

		# @boot.speciality = specs[i]*", " #if specs[i].present?
		# @boot.location   = locations[i]*", " #if locations[i].present?

		# @boot.website    = websites[i] #if websites[i].present?
		# @boot.email      = emails[i] #if emails[i].present?
		# @boot.facebook   = facebooks[i] #if facebooks[i].present?
		# @boot.twitter    = twitters[i] #if twitters[i].present?

		# @boot.job_guarantee       = more_info[i][:job_guarantee]
		# @boot.job_assistance      = more_info[i][:job_assistance]
		# @boot.apprenticeship  	  = more_info[i][:apprenticeship]
		# @boot.accreditation  	  = more_info[i][:accreditation]
		# @boot.post_grad_resources = more_info[i][:post_grad_resources]
		# @boot.housing       	  = more_info[i][:housing]
		# @boot.visa_assistance	  = more_info[i][:visa_assistance]

		# @boot.save
	# end

  end

  desc "Delete All Bootcamps from Database"
  task del_all: :environment do
	Bootcamp.destroy_all
  end

end
