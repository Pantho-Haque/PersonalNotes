# MongoDB

## installation

```sh
    sudo systemctl start mongod  # to start mongodb
    sudo systemctl status mongod # verify mongodb started successfully
    sudo systemctl stop mongod # stop mongodb server
```

## CRUD Operation

```sh
show dbs   // list of all databases
use DBNAME // create a database named DBNAME
db         //  enter the database
```

### Create

```js
// db-object,product-collection
db.product.insertOne({ name: "pantho", age: 20, alive: true });
db.product.insertMany([
  { name: "redwan", age: 21, alive: true },
  { name: "fariha", age: 19, alive: true },
]);
// returns{
//     "acknowledged":true,
//     "insertedId":ObjectID("an_unique_id")
// }
```

### Read

```js
// find(filter-condition, projection)
db.product
  .find(
    { withProperty: "desiredValue" },
    {
      skippedProperty: 0, // to not get the property we should put zero
    }
  )
  .limit(how_many_Output_we_want)
  .skip(how_many_Output_we_want_to_skip);
// returns the value with an uniquie id
```

### Update

```js
//updateOne(condition, {$set:{newValue}} ) -> changes 1st object
db.product.updateOne(
  { anyPropertyOfDesiredObject: "itsDesiredValue" },
  { $set: { whichPropertyShouldUpdate: "newValueOfThatProperty" } }
);

//updateMany(condition, {$set:{newValue}} ) -> changes all object which satisfies condition
db.product.updateMany(
  { anyPropertyOfDesiredObject: "itsDesiredValue" },
  { $set: { whichPropertyShouldUpdate: "newValueOfThatProperty" } }
);
```

### Delete

```js
//dleteOne(condition) -> deletes 1st object
db.product.deleteOne({ anyPropertyOfDesiredObject: "itsDesiredValue" });

//deleteMany(condition) -> delete all object which satisfies condition
db.product.updateMany({ anyPropertyOfDesiredObject: "itsDesiredValue" });
```
