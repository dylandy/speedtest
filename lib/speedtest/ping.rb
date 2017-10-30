module Speedtest
  class Speedtest
    def ping(server)
      round = []
      10.times do 
        start = Time.new
        milli_sec = Speedtest::second_to_milli(start)
        begin
          Nokogiri::HTML(open("#{server}/speedtest/latency.txt?x=#{milli_sec}"))
          round << Time.new - start
        rescue 
          round << 999999
        end
      end  
      round.sort!
      # average timing
      (round[0...5].inject(:+)) * 1000 / 5
    end
  end
end
