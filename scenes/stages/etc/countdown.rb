


class Countdown
	def initialize(x)
		@endtime = Time.now + x
	end

	def timecount? 
		Time.now < @endtime
	end

	def now
		@endtime - Time.now 
	end
end



