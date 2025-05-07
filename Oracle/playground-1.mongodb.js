//creating a new database or use an existing db
use('shop');


//Collections
use('shop');
db.createCollection('users');//no fixed attributes(schema less)


//collection with flexible schema
use('shop');
db.createCollection('categories',
    {validator:{
        $jsonSchema:{
            bsonType:"object",
            required:['code','name'],
            properties:{
                code:{
                    bsonType:'string',
                    description:'code is required'
                },
                name:{
                    bsonType:'string',
                    description:'name is required'
                }
            }
        }
    }

}
);


//Insert data
//Inserting only one document
let user={
    "name":"John Doe",
    "email":"john@gmail,com",
    "city":"Kandy",
    "type":"admin"
};
use('shop');
db.getCollection('users').insertOne(user);

//Inserting multiple documents at once
let user_list=[
    {"name":"Sam Silva","city":"colombo","type":"customer","phone":"077777"},
    {"name":"Angelo","city":"Kandy","type":"customer","age":33},
    {"name":"Ben","city":"Kegalle"}
];
use('shop');
db.getCollection('users').insertMany(user_list);



//Selecting all the data from a collection
use('shop');
db.getCollection('users').find();//returns an array of json objects


//selecting only a specific set of attributes
//display name and city of all the users
use('shop');
db.getCollection('users').find({},{"name":1,"city":1});//projection using fields


//Selecting data based on a specific value for a field
//display details of all the users from kandy
use('shop');
db.getCollection('users').find({"city":"Kandy",});//Equality condition


//select name & city of all users from kandy
use('shop');
db.getCollection('users').find(
    {"city":{$regex:"Kandy",$options:"i"}},//selection criteria
    {"name":1,"city":1}//projection
);

//== : $eq
//select all users from colombo
use('shop');
db.getCollection('users').find({'city':'colombo'});
//or
use('shop');
db.getCollection('users').find({"city":{$eq:"colombo"}});

//AND:$and
//select all the users from colombo whose age is 20
use('shop');
db.getCollection('users').find({$and:[{"city":"colombo"},{"age":20}]});


//OR:$or
//select all the users from colombo who are older than 30
use('shop');
db.getCollection('users').find({$or:[
    {"city":"colombo"},
    {"age":{$gt:30}}
]});


//!=$ne
//select all the users who are not from kegalle
use('shop');
db.getCollection('users').find({"city":{$ne:"kegalle"}});


//>:$gt
//select all users whose age is greater than 20
use('shop');
db.getCollection('users').find({"age":{$gt:20}});

//>=:$gte
//select name of all users whose age is greater than or equal than or equal to 33
use('shop');
db.getCollection('users').find({"age":{$gte:33}},{"name":1});


//<:$lt
//select name of all users whose age is less than 20
use('shop');
db.getCollection('users').find({"age":{$lt:20}},{"name":1});


//<=:$lte
use('shop');
db.getCollection('users').find({"age":{$lte:20}});


//IN:$in
//select all the users from kandy, kegalle
use('shop');
    db.getCollection('users').find({"city":{$in:['Kandy','kandy','kegalle']}});



//NOT IN:$nin
//select all the users who are not from kandy
use('shop');
db.getCollection('users').find({"city":{$nin:['kandy','Kandy']}});


//Updating Documents
//Update the user with the username ben to have user type as 'customer'
use('shop');
db.getCollection('users').updateMany(
    {"name":"Ben"},
    {$set:{"type":'customer'}
});


//update the user with the email john@gmail.com with the age set to 24, city set to Matara
Use('shop');
db.getCollection('users').updateMany(
    {"email":"john@gmail,com"},
    {$set:{"age":24,"city":"Matara"}}
);


//Deleting documents
//Deleting all users from kegalle
//db.getcollection('<collection_name>').deleteMany({<selection_criteria>});
use('shop');
db.getCollection('users').deleteMany({"city":"kegalle"});


//Deleting a collection
//Delete the collection 'categories' from your database
use('shop');
db.getCollection('categories').drop();

// Example 2
//Crieating database
use('Supermarcket');
//Crieate the collections
use('Supermarcket');
db.createCollection('item2',
      {
        validator:{
            $jsonSchema:{
                bsonType:"object",
                required:["name","price","stock"],
                properties:{
                    name:{
                        bsonType:"string",
                        description:"Name is required"
                    },
                    price:{
                        bsonType:"number",
                        description:"Price is required",
                        minimum:0.00
                    },
                    stock:{
                        bsonType:"number",
                        description:"stock is required",
                        minimum:0.00,
                        maximum:100
                        }
                }
            }
        }
      }
)

let item_list=[
    {"name":"ABC","price":100.00,"stock":30,"supliers":[
        {"sup_name":"Abc Company","contact":"088888888"},
        {"sup_name":"Werty Company","contact":"098888888"}
    ]
  },
  {"name":"BCD","price":1200.00,"stock":10,"cterory":"Electionics"},
  {"name":"CDE","price":1250.00,"stock":20,"cterory":"Misc",
    "variation":{"size":"L","colour":"black"}
  }
];
use('Supermarcket');
db.getCollection('item2').insertMany(item_list);

//2. Select all the document in the collection
use('Supermarcket');
db.getCollection('item2').find();

//3. Selcet item name and prie of item with their stock reached to 0
use('Supermarcket');
db.getCollection('item2').find({"stock":0.00},{"name":1,"price":1});

//4. Select items with their prices ovet 1000 and stock over 100
use('Supermarcket');
db.getCollection('item2').find({$and:[{"price":{$gt:1000}},{"stock":{$gt:100}}]});

//5. Selcet items with supllier name as 'Abc company'
use('Supermarcket');
db.getCollection('item2').find({$or:[{"category":"Electronics"},{"stock":5}]});

//Aggregate function in NoSQL
//db.<Collection>.aggregate([<aggregate functions>]);
//Aggregate Function:
// {$group:{_id:<grouping attributes>,<aggregate attribute>:<aggregate operatior>}}

//7. Select average price of an item
use('Supermarcket');
db.getCollection('item2').aggregate([
    {
        $group:{
          _id: null,
             averagePrice:{$avg:"$price"}
            
          }
        
    }
]);

//8.Select maximum stock from the collection
use('Supermarcket');
db.getCollection('item2').aggregate([
    {
        $group: {
          _id: null,
            maxStock:{$max:"$stock"}          
        }
    }
]);

//9. Select maximum stock for each category
use('Supermarcket');
db.getCollection('item2').aggregate([
    {
        $group: {
          _id: "Cactegory",
          maxStockByCategory:{$max:"$stock"}
         
          
        }
    }
]);



