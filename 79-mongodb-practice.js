// To run ./mongo 79-mongodb-practice.js

db = db.getSiblingDB('rt')

/*
Write a MongoDB query to display all the documents in the collection restaurants.
*/

print('results0')
results0 = db.restaurants.find()
results0.forEach(printjson)
print('\n')

/* 
Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine for all the documents in the collection restaurant. 
*/
print('results1')
results1 = db.restaurants.find({restaurant_id:1,name:1, borough: 1, cuisine: 1})
results1.forEach(printjson)
print('\n')


/*
Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine, but exclude the field _id for all the documents in the collection restaurant. 
*/
print('results2')
results2 = db.restaurants.find({}, {restaurant_id:1,name:1, borough: 1, cuisine: 1, _id:0})
results2.forEach(printjson)
print('\n')
/*
 Write a MongoDB query to display the fields restaurant_id, name, borough and zip code, but exclude the field _id for all the documents in the collection restaurant. 
*/
print('results3')
results3 =db.restaurants.find({}, {"restaurant_id":1,"name":1, "borough": 1, "address.zipcode": 1, "_id":0})
results3.forEach(printjson)
print('\n')

/*
Write a MongoDB query to display all the restaurant which is in the borough Bronx. 
*/   
print('results4')
results4 = db.restaurants.find({"borough": "Bronx"})
results4.forEach(printjson)
print('\n')

/*
Write a MongoDB query to display the first 5 restaurant which is in the borough Bronx. 
*/
print('results5')
results5 = db.restaurants.find({"borough": "Bronx"}).limit(5)
results5.forEach(printjson)
print('\n')


/*
Write a MongoDB query to display the next 5 restaurants after skipping first 5 which are in the borough Bronx.
*/
print('results6')
results6 =  db.restaurants.find({"borough": "Bronx"}).skip(5).limit(5)
results6.forEach(printjson)
print('\n')

/*
Write a MongoDB query to find the restaurants who achieved a score more than 90. 
*/
print('results7')
results7 =  db.restaurants.find( {"grades.score":{$gt:90}})
// db.restaurants.find({grades : { $elemMatch:{"score":{$gt : 90}}}})
results7.forEach(printjson)
print('\n')

/*
Write a MongoDB query to find the restaurants that achieved a score, more than 80 but less than 100.
*/
  
// db.restaurants.find({grades : { $elemMatch:{"score":{$gt : 80, $lt:100}}}}).pretty()
print('results8')
results8 = db.restaurants.find({"grades.score":{$gt : 80, $lt:100}})
results8.forEach(printjson)
print('\n')
/*
Write a MongoDB query to find the restaurants which locate in latitude value less than -95.754168.
*/
print('results9')
results9 = db.restaurants.find({"address.coord":{$lt:-95.754168}})

results9.forEach(printjson)
print('\n')
/*
Write a MongoDB query to find the restaurants that do not prepare any cuisine of 'American' and their grade score more than 70 and latitude less than -65.754168. 
*/
print('results10')
results10 =   db.restaurants.find( 
    {$and: 
      [ 
          {cuisine: {$ne: "American"}},
          {"grades.score": {$lt: 70}}, 
          {"address.coord":{$lt:-65.754168}}
     ] 
    }
 )

results10.forEach(printjson)
print('\n')

/*
Write a MongoDB query to find the restaurants which do not prepare any cuisine of 'American' and achieved a score more than 70 and located in the longitude less than -65.754168.
Note : Do this query without using $and operator. 
*/

print('results11')
results11 = db.restaurants.find( 
  {
      cuisine: {$ne: "American"},
      "grades.score": {$lt: 70}, 
      "address.coord":{$lt:-65.754168}
  }
 )

results11.forEach(printjson)
print('\n')
/*
Write a MongoDB query to find the restaurants which do not prepare any cuisine of 'American ' and achieved a grade point 'A' not belongs to the borough Brooklyn. The document must be displayed according to the cuisine in descending order. 
*/
print('results12')
results12 =
  db.restaurants.find(
    {
      cuisine: {$ne: "American"},
      "grades.grade": "A",
      borough: {$ne: "Brooklyn"}
    }
  ).sort({cuisine:-1})

results12.forEach(printjson)
print('\n')
/*
Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants 
which contain 'Wil' as first three letters for its name. 
*/
print('results13')
results13 =  db.restaurants.find(
    {
      name: /^Wil/

    },
    {
      restaurant_id:1,
      name:1,
      borough:1,
      cuisine:1
    }
  )

  results13.forEach(printjson)
  print('\n')
/*
Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which contain 'ces' as last three letters for its name. 
*/

print('results14')
results14 =db.restaurants.find(
    {
      name: /ces$/

    },
    {
      restaurant_id:1,
      name:1,
      borough:1,
      cuisine:1
    }
  )

  results14.forEach(printjson)
  print('\n')
/*
 Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which contain 'Reg' as three letters somewhere in its name. 
*/
print('results15')
results15 =    db.restaurants.find(
    {
      name: /Reg/

    },
    {
      restaurant_id:1,
      name:1,
      borough:1,
      cuisine:1
    }
  )

results15.forEach(printjson)
print('\n')
/*
Write a MongoDB query to find the restaurants which belong to the borough Bronx and prepared either American or Chinese dish.
*/
print('results16')
results16 =    db.restaurants.find(
    {
      borough: "Bronx",
      $or:
      [
        {cuisine: "American"},
        {cuisine:"Chinese"}
      ]
    }
  )

  results16.forEach(printjson)
  print('\n')

/*
 Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which belong to the borough Staten Island or Queens or Bronx or Brooklyn. 
*/
print('results17')
results17 =    db.restaurants.find(
      {
        borough: {$in:
              ["Staten Island", "Queens", "Bronx","Brooklyn"]}
      },
      {
      restaurant_id:1,
      name:1,
      borough:1,
      cuisine:1
    }
  )  
      
results17.forEach(printjson)
print('\n')

/*
 Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which are not belonging to the borough Staten Island or Queens or Bronxor Brooklyn. 
*/
print('results18')
results18 =    db.restaurants.find(
      {
        borough: {$nin:
              ["Staten Island", "Queens", "Bronx","Brooklyn"]}
      },
      {
      restaurant_id:1,
      name:1,
      borough:1,
      cuisine:1
    }
  ) 
  results18.forEach(printjson)
  print('\n')


/*
Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which achieved a score which is not more than 10. 
*/
print('results19')
results19 = db.restaurants.find(
      {
        "grades.score": {$lte: 10}
      },
      {
      restaurant_id:1,
      name:1,
      borough:1,
      cuisine:1
    }
  ) 
  results19.forEach(printjson)
  print('\n')