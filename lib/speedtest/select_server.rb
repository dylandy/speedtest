module Speedtest
  class Speedtest
    def select_server 
			page = Nokogiri::HTML(open("http://www.speedtest.net/speedtest-config.php"))
			page = page.css("client").first
			ip = page.attr("ip")
			longtitude = page.attr("lon")
			latitude = page.attr("lat")

			origin_point = GetPoint.new(latitude, longtitude)
			puts "Your IP: #{ip}"

      server_page = Nokogiri::HTML(open("http://www.speedtest.net/speedtest-servers.php"))
			servers = server_page.css("server")
      servers_info = servers.map{|x| [x.attr("url"),  x.attr("lat"), x.attr("lon")]}
      sorted_servers = servers_info.map { |i|
        {
          :distance => origin_point.distance(GetPoint.new(i[1], i[2])),
          :url => i.first.split(/(http:\/\/.*)\/speedtest.*/)[1]
        }
      }.sort_by { |x| x[:distance] }
      

			# sort the nearest 10 by download latency
      puts "checking ping"
      progress = ProgressBar.create(:total => 10, :progress_mark  => '=',:format => "%a %b>%i %p%% %t",)
			latency_sorted_servers = sorted_servers[0..9].map { |x|
        progress.increment
				{
				:latency => ping(x[:url]),
				:url => x[:url]
				}
      }.sort_by { |x| x[:latency] }
      selected = latency_sorted_servers.first
      puts "Automatically selected server: #{selected[:url]} - #{selected[:latency].round(2)} ms"
      @server_root = selected[:url]
      selected
		end
  end
end
