module Speedtest
  class GetPoint
    attr_accessor :latitude, :longtitude
    def initialize(latitude, longtitude)
      @latitude=latitude.to_f
      @longtitude=longtitude.to_f
    end
    def to_s
      "[#{@latitude}, #{@longtitude}]"
    end
    def distance(p2)
      Math.sqrt((p2.longtitude - @longtitude) ** 2 + (p2.latitude - @latitude) ** 2)
    end
  end
end
