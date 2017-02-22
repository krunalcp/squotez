require Rails.root.join('lib', 'parser', 'parser')

SIGNS_LIST =  {
                "0" => "aries", 
                "1" => "taurus", 
                "2" => "gemini", 
                "3" => "cancer", 
                "4" => "leo", 
                "5" => "virgo", 
                "6" => "libra", 
                "7" => "scorpio", 
                "8" => "sagittarius", 
                "9" => "capricorn", 
                "10" => "aquarius", 
                "11" => "pisces"
              }

# Email RegX
EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
