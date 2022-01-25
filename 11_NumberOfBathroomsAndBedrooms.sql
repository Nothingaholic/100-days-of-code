-- Stratascratch
-- Airbnb Interview Questions
/*
Number Of Bathrooms And Bedrooms
Find the average number of bathrooms and bedrooms for each city’s property types. 
Output the result along with the city name and the property type.

Table: airbnb_search_details

id                              int
price                           float
property_type                   varchar
room_type                       varchar
amenities                       varchar
accommodates                    int
bathrooms                       int
bed_type                        varchar
cancellation_policy             varchar
cleaning_fee                    bool
city                            varchar
host_identity_verified          varchar
host_response_rate              varchar
host_since                      datetime
neighbourhood                   varchar
number_of_reviews               int
review_scores_rating            float
zipcode                         int
bedrooms                        int
beds                            int
*/

select city,
        property_type,  
        avg(bedrooms)as average_bedrooms,
        avg(bathrooms) as average_bathrooms
from airbnb_search_details
group by city, property_type;