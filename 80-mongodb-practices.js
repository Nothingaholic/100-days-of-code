
db = db.getSiblingDB('rt')

// Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants
//  which prepared dish except 'American' and 'Chinees' or restaurant's name begins with letter 'Wil'. 
print('results20')
results20 = db.restaurants.find(
    {
        $or: 
        [
            { cousine: {$nin: ["American", "Chinees"]}},
            {name: /^Wil/}
        ]
      

    },
    {
      restaurant_id:1,
      name:1,
      borough:1,
      cuisine:1
    }
  )
results20.forEach(printjson)
print('\n')


// Write a MongoDB query to find the restaurant Id, name, and grades for those restaurants 
// which achieved a grade of "A" and scored 11 on an ISODate "2014-08-11T00:00:00Z" among many of survey dates.
print('results21')
results21 = db.restaurants.find(
    {
        "grades.date": ISODate("2014-08-11T00:00:00Z"), 
        "grades.grade": "A",
        "grades.score": 11
        
    },
    {
        restaurant_id: 1,
        name: 1,
        grades: 1
    }
)
results21.forEach(printjson)
print('\n')

// Write a MongoDB query to find the restaurant Id, name and grades for those restaurants 
// where the 2nd element of grades array contains a grade of "A" and score 9 on an ISODate "2014-08-11T00:00:00Z". 
print('results22')
results22 = db.restaurants.find(
    {
        "grades.1.grade": "A", // .1 to get the 2nd element of the array
        "grades.1.score": 9,
        "grades.1.date": ISODate("2014-08-11T00:00:00Z")
    },
    {
        restaurant_id: 1,
        name: 1,
        grades: 1
    }
)
results22.forEach(printjson)
print('\n')

// Write a MongoDB query to find the restaurant Id, name, address and geographical location 
// for those restaurants where 2nd element of coord array contains a value which is more than 42 and upto 52.

print('results23')
results23 = db.restaurants.find(
    {
        "address.coord.1": {$gt: 42, $lte: 52}
    },
    {
        restaurant_id: 1,
        name: 1,
        address: 1,
        "address.coord": 1
    }
)
results23.forEach(printjson)
print('\n')

// Write a MongoDB query to arrange the name of the restaurants in ascending order along with all the columns.

print('results24')
results24 = db.restaurants.find().sort({name:1})
results24.forEach(printjson)
print('\n')

// Write a MongoDB query to arrange the name of the restaurants in descending along with all the columns. 

print('results25')
results25 = db.restaurants.find().sort({name:-1})
results25.forEach(printjson)
print('\n')

//  Write a MongoDB query to arranged the name of the cuisine in ascending order 
// and for that same cuisine borough should be in descending order. 
print('results26')
results26 = db.restaurants.find().sort(
    {cuisine:1},
    {borough:-1}
)
results26.forEach(printjson)
print('\n')

// Write a MongoDB query to know whether all the addresses contains the street or not. 

print('results27')
results27 = db.restaurants.find(
    {
        "address.street": {$exists: true}
    }
)
results27.forEach(printjson)
print('\n')


// Write a MongoDB query which will select all documents in the restaurants collection 
// where the coord field value is Double. 

print('results28')
results28 = db.restaurants.find(
    {
        "address.coord": {$type: "double" }
    }
)
results28.forEach(printjson)
print('\n')



// Write a MongoDB query which will select the restaurant Id, name and grades for those restaurants
//  which returns 0 as a remainder after dividing the score by 7. 

print('results29')
results29 = db.restaurants.find(
    {
        "grades.score": {$mod: [7,0]}
    },
    {
        restaurant_id: 1,
        name: 1,
        grades: 1
    }

)
results29.forEach(printjson)
print('\n')



// Write a MongoDB query to find the restaurant name, borough, longitude and attitude and cuisine 
// for those restaurants which contains 'mon' as three letters somewhere in its name. 

print('results30')
results30 = db.restaurants.find(
    {
        name: /mon/
    },
    {
        restaurant_id:1, 
        name: 1,
        borough: 1,
        "address.score":1,
        cuisine: 1
    }
)
results30.forEach(printjson)
print('\n')

// Write a MongoDB query to find the restaurant name, borough, longitude and latitude and cuisine for those restaurants which contain 'Mad' as first three letters of its name. 


print('results31')
results31 = db.restaurants.find(
    {
        name: /^Mad/
    },
    {
        restaurant_id:1, 
        name: 1,
        borough: 1,
        "address.score":1,
        cuisine: 1
    }
)
results31.forEach(printjson)
print('\n')