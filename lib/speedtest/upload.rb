module Speedtest
  class Speedtest
    def upload_thread(url, current_data)
      page = Curl.post(url, { "content0" => current_data }.to_json) do |http|
        http.headers['Content-Type'] = 'application/json'
      end
      Thread.current["uploaded"] = page.body_str.split('=')[1].to_i
    end

    def upload
      runs = 4
      data = []
      UPLOAD_SIZES.each do |size|
        runs.times do 
          data << random_string([*('A'..'Z')], size)
        end  
      end  

      threads = []
      start_time = Time.new
      threads = data.map do |data| 
        Thread.new(data) do |current_data|
          milli_sec = Speedtest::second_to_milli(Time.new)
          upload_thread("#{@server_root}//speedtest/upload.php?x=#{rand}", current_data)
        end  
      end  
      total_uploaded = 0
      threads.each do |t|  
        t.join
        total_uploaded += t["uploaded"]
      end  
      total_time = Time.new - start_time 
      puts "Took #{total_time} seconds to upload #{total_uploaded} bytes"
      total_uploaded * 8 / total_time
    end
  end
end
