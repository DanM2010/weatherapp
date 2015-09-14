class WeatherForecast

# Instantiate a new weather forecast object and prompt the user for their desired location
	def self.get_user_location
		weather_forecast = WeatherForecast::new
		puts "Tell me where you are and I'll let you know the weather?"
		@location = gets.strip
	end
	
# Instantiate a new object from the Weatherman gem and ask for current weather details for the desired location.
# Ask the user if they want a five-day forecast and return as applicable 
	def self.get_weather_now
		client = Weatherman::Client.new
		response = client.lookup_by_location(@location)
		unit = response.units['temperature']
		puts "In #{response.location['city']} it is currently #{response.condition['temp']}#{unit} and #{response.condition['text']}"
		puts "Would you like a five-day forecast? (y/n)"
		five_day = gets[0].downcase
		if five_day == "y"
			forecast = response.forecasts
			forecast.each_index do |day_plus|
				case day_plus
				when 0
					fcast_day = "Today"
				when 1
					fcast_day = "Tomorrow"
				when 2..4
					fcast_day = "On #{forecast[day_plus]['day']}"
				end
				puts "#{fcast_day} there will be lows of #{forecast[day_plus]['low']}#{unit} with highs of #{forecast[day_plus]['high']}#{unit}.\n"
				puts "The conditions will be #{forecast[day_plus]['text']}."
			end
		end
	end
	
	attr_accessor :location, :client, :response ,:forecast, :fcast_day
end


# load the yahoo_weatherman ruby gem
require 'yahoo_weatherman'

WeatherForecast.get_user_location
WeatherForecast.get_weather_now
