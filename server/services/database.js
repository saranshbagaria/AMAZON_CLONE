const mongodb = require('mongoose')

const MONGO_URL = "mongodb+srv://saranshamazon0108cs191107:ooWxb91pVC8nT3QI@cluster0.kcztebl.mongodb.net/?retryWrites=true&w=majority";
// const client = new MongoClient(uri, { 
//     useNewUrlParser: true, 
//     useUnifiedTopology: true,
//      serverApi: ServerApiVersion.v1 });
// client.connect(err => {
//   const collection = client.db("test").collection("devices");
//   // perform actions on the collection object
//   client.close();
// });
// mongodb.

mongodb.connection.once('open', () => {
    console.log("mongo db connection is ready to good");
})

mongodb.connection.on('error', (err) => {
    console.error(err);
})


async function mongoConnect() {
    await mongodb.connect(MONGO_URL, {
        useNewUrlParser: true,

        useUnifiedTopology: true
    });
}

async function mongoDisconnect() {
    await mongodb.disconnect();
}

module.exports = { mongoConnect, mongoDisconnect };