module Speedtest
  class Speedtest
    def download_thread(url)
      Thread.current["downloaded"] = open(url).size
			page = Nokogiri::HTML(open(url))
    end
    def download
			threads = []
			start_time = Time.new
			DOWNLOAD_FILES.each do |f| 
        (DOWNLOAD_RUNS).times do |i|
					threads << Thread.new(f) do |myPage|
						msec = Speedtest::second_to_milli(Time.new)
						download_thread("#{@server_root}/#{myPage}?x=#{msec}&y=#{i}")
          end	
        end	
      end	
			total_downloaded = 0
			threads.each do |t|  
				t.join
				total_downloaded += t["downloaded"]
      end	
			total_time = Time.new - start_time 
			puts "Took #{total_time} seconds to download #{total_downloaded} bytes"
			total_downloaded * 8 / total_time
    end
  end
end
