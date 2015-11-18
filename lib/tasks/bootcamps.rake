namespace :bootcamps do
  desc "Scrape All Boostcamps from: https://www.coursereport.com/schools/"
  task scrape: :environment do


	require "open-uri"
	require "nokogiri"

	url = "https://www.coursereport.com/schools"
	page = Nokogiri::HTML(open(url))

	# Max schools number
	search_max = page.css("div#main-content h1 span").text
	max_schools = search_max.split.first.to_i

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
	more_info    = []


		counter = 0
	# Linking to Page
	links.each do |t|
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

		page = Nokogiri::HTML(doc)
		# Title
		page.css("div.navigable.col-md-8 div.main-header.hide-on-mobile h1").each do |t|
			titles << t.text
			puts "#{counter +=1}: #{t.text}"
		end

		# About
		page.css("section.about div.expandable p").each do |about|
			x = about.content
			abouts << x
		end

		# Images
		page.css("div.col-xs-12.visible-xs.visible-sm div.school-image").each do |pic|
			if pic.at_css("img")
				x = pic.at_css("img")['src']
				images << x
			else
				puts "Image non-exist"
			end
		end

		# ****************  DETAILS *****************

		# speciality  
		spec_arr = []
		page.css("ul.school-info li.school-tracks a").each do |spec|
			spec_arr << spec.text
		end
		specs << spec_arr

		# Locations
		loc_arr = []
		page.css("ul.school-info li.location a").each do |loc|
			loc_arr << loc.text
		end
		locations << loc_arr

		# website
		page.css("ul.school-info li.url").each do |web|
			if web.at_css("a")["itemprop"]
				websites << web.text
			end
		end

		# email
		page.css("ul.school-info li.email").each do |email|
			emails << email.text
		end

		# facebook
		page.css("ul.school-info li.facebook").each do |face|
			facebooks << face.at_css("a")["href"]
		end

		# twitter
		page.css("ul.school-info li.twitter").each do |twit|
			twitters << twit.at_css("a")["href"]
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
			more_info << more_object
	end

	links.length.times do |i| 
		@boot = Bootcamp.new

		@boot.title 	 = titles[i]
		@boot.about 	 = abouts[i]
		@boot.image 	 = images[i] if images[i].present?

		@boot.speciality = specs[i]*"," if specs[i].present?
		@boot.location   = locations[i]*"," if locations[i].present?

		@boot.website    = websites[i] if websites[i].present?
		@boot.email      = emails[i] if emails[i].present?
		@boot.facebook   = facebooks[i] if facebooks[i].present?
		@boot.twitter    = twitters[i] if twitters[i].present?

			# puts more_info[i][:apprenticeship]
		@boot.job_guarantee       = more_info[i][:job_guarantee]
		@boot.job_assistance      = more_info[i][:job_assistance]
		@boot.apprenticeship  	  = more_info[i][:apprenticeship]
		@boot.accreditation  	  = more_info[i][:accreditation]
		@boot.post_grad_resources = more_info[i][:post_grad_resources]
		@boot.housing       	  = more_info[i][:housing]
		@boot.visa_assistance	  = more_info[i][:visa_assistance]

		@boot.save
	end

  end

  desc "Delete All Bootcamps from Database"
  task delete_bootcamp_all: :environment do
	Bootcamp.destroy_all
  end

end
