# README

To use app:

git clone https://github.com/artemyez/cats_dealer_api.git \
bundle install \
Put .env.development and .env.test variables as in the example. \
rails s 

Put /api/v1/cats to url to see all available results. \
Use params user_location or cats_type to see filtered results. \
To see the best deal you need to use both user_location and cats_type. 
