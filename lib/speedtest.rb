require "ruby-progressbar"
require "open-uri"
require "nokogiri"
require "curb"
require "json"
Dir[File.expand_path("#{File.dirname(__FILE__)}/speedtest/*.rb")].each {|file| require file}

module Speedtest
  class Speedtest
		DEBUG=false
		DOWNLOAD_FILES = [
			'speedtest/random750x750.jpg',
			'speedtest/random1500x1500.jpg',
		]
		UPLOAD_SIZES = [
			197190,
			483960
		]
		DOWNLOAD_RUNS = 5 

    def self.second_to_milli(time)
      (time.to_f * 1000).to_i
    end

    def random_string(alphabet, size)
      (1..size).map {alphabet[rand(alphabet.length)] }.join
    end

    def pretty_speed(speed)
			units = [ "bps", "Kbps", "Mbps", "Gbps"]
			idx = 0
			while speed > 1024 #&& idx < units.length - 1
				speed /= 1024
				idx+=1
			end
			"%.2f #{units[idx]}" % speed
    end

    def run
      server = select_server
			ping = server[:latency]
			puts "Server #{@server_root}"
			download_rate = download
			puts "Download: #{pretty_speed download_rate}"
			upload_rate = upload
			puts "Upload: #{pretty_speed upload_rate}"
			{:server => @server_root, :ping => ping, :download => (pretty_speed download_rate), :upload => (pretty_speed upload_rate)}
    end
  end
end
