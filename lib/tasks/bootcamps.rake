namespace :bootcamps do

  desc "Scrape All Boostcamps from: https://www.coursereport.com/schools/"
  task get_all: :environment do

	require "open-uri"
	require "nokogiri"

	url = "https://www.coursereport.com/schools"
	page = Nokogiri::HTML(open(url))

	# Max schools number, Currently Their School search not work properly.
	# search_max = page.css("div#main-content h1 span").text
	# max_schools = search_max.split.first.to_i

	links  = []
	(1..15).each do |i|
		url_paging = url + "?page=#{i}"
		page = Nokogiri::HTML(open(url_paging))
		
		# Getting link titles
		link = page.css("div.school-header h3").each do |l|
			x = l.at_css('a')['href']
			x.slice! "/schools/"
	    	links << x
		end
	end
	

	counter = 0
	# Linking to Page
	links.each do |t|
		url_link = url + "/#{t}"
	# 1.times do
	# 	url_link = 'https://www.coursereport.com/schools/turntotech'
	# url_link = 'https://www.coursereport.com/schools/code-fellows'

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
			@boot.title = t.text if t.text.length > 1
			puts "#{counter +=1}: #{t.text}"
		end

		# About
		about_arr = []
		page.css("section.about div.expandable p").each do |about|
			about_arr << about.content if about.content
		end
		@boot.about = about_arr.join(' ')

		# Images
		page.css("div.col-xs-12.visible-xs.visible-sm div.school-image").each do |pic|
			@boot.remote_image_url = pic.at_css("img")['src'].downcase if pic.at_css("img")
		end

		# # ****************  DETAILS *****************
		# speciality  
		speciality_arr = []
		page.css("ul.school-info li.school-tracks a").each do |spec|
			speciality_arr << spec.text if spec.text
		end
		@boot.speciality_ids = Speciality.where(:title => speciality_arr).pluck(:id)


		# Locations
		loc_arr = []
		page.css("ul.school-info li.location a").each do |loc|
			loc_arr << loc.text if loc.text
		end
		@boot.location_ids = Location.where(:title => loc_arr).pluck(:id)


		# website
		x= []
		page.css("ul.school-info li.url").each do |web|
			# @boot.website = web.text if web.at_css("a")["itemprop"]
			x << web.at_css("a")['href']
		end
			puts x[0]
			@boot.website = x[0]

		# email
		page.css("ul.school-info li.email").each do |email|
			@boot.email = email.text if email.text
		end

		# facebook
		page.css("ul.school-info li.facebook").each do |face|
			@boot.facebook = face.at_css("a")["href"] if face.at_css("a")["href"]
		end

		# twitter
		page.css("ul.school-info li.twitter").each do |twit|
			@boot.twitter = twit.at_css("a")["href"] if twit.at_css("a")["href"]
		end


		# **************** More Information *****************
		arr = []
		page.css("div#more-info div.panel-body p").each do |more|
			arr << more.text
		end

		@boot.job_guarantee        = arr[0]
		@boot.job_assistance       = arr[1]
		@boot.apprenticeship  	   = arr[2]
		@boot.accreditation  	   = arr[3]
		@boot.post_grad_resources  = arr[4]
		@boot.housing       	   = arr[5]
		@boot.visa_assistance	   = arr[6]

		@boot.save
	end

  end



  desc "Get all locations/Specs from Bootcamps"
  task get_locs_specs: :environment do

	require "open-uri"
	require "nokogiri"

	url = "https://www.coursereport.com/schools"
	page = Nokogiri::HTML(open(url))

	links  = []
	(1..15).each do |i|
		url_paging = url + "?page=#{i}"
		page = Nokogiri::HTML(open(url_paging))
		
		# Getting link titles
		link = page.css("div.school-header h3").each do |l|
			x = l.at_css('a')['href']
			x.slice! "/schools/"
	    	links << x
		end
	end

all_locations_arr = []

	links.each do |t|
		url_link = url + "/#{t}"

		begin
			doc = open(url_link)
			Link.create(:link => url_link.to_s)
		rescue OpenURI::HTTPError => http_error
		    # http_error.message is the numeric code and text in a string 
		    status = http_error.io.status[0].to_i # => 3xx, 4xx, or 5xx
		    puts "Got a bad status code #{status}"
		end

		page = Nokogiri::HTML(doc)
		# # ****************  DETAILS *****************
		# speciality  
		speciality_arr = []
		page.css("ul.school-info li.school-tracks a").each do |spec|
			speciality_arr << spec.text if spec.text
		end
			# Saving to Speciality DB
			speciality_arr.each do |s|
				unless Speciality.where(:title => s).exists?
					Speciality.create(:title => s)
				end
			end 

		# current_user.profile.bootcamp_reviews.where(bootcamp: @bootcamp).exists?

		# Locations
		loc_arr = []
		page.css("ul.school-info li.location a").each do |loc|
			loc_arr << loc.text if loc.text
		end

		loc_arr.each do |l|
			all_locations_arr << l unless all_locations_arr.include?(l)
		end
	end

		all_locations_arr.sort_by! {|s| s.downcase}

			all_locations_arr.each do |loc|
				unless Location.where(:title => loc).exists?
					Location.create(:title => loc)
				end
			end

  end


  desc "Delete All Bootcamps from Database"
  task del_all: :environment do
	Bootcamp.destroy_all
  end

end
