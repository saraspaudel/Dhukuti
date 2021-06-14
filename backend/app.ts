import express from 'express';
import mysql from 'mysql';

const app = express();

app.use(express.json()); //Used to parse JSON bodies
app.use(express.urlencoded()); //Parse URL-encoded bodies

const port = 3000;

var connection = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: '1234',
  database: 'dhukuti'
});

connection.connect((error) => {
  if (error) throw error;
});

app.post('/login', (req, res) => {
  var email = req.body.email;
  var password = req.body.password;

  connection.query('SELECT * FROM dhukuti.Users;', function (error, results, fields) {
    if (error) throw error;
    console.log('Users are : ', results)
    let match = results.find(element => element.email === email);
    
    if (match == null) {
      res.sendStatus(404);
      console.log("Couldn't find user by that email address.")
    } else if (match.password != password) {
      res.sendStatus(404);
      console.log("Wrong password")
    }
    else {
      console.log("User found")
      res.sendStatus(200);
    }
  });
})

app.post('/register', (req, res) => {
  console.log('Got body: ', req.body);
  res.sendStatus(200);

  var firstName = req.body.FirstName;
  var lastName = req.body.LastName;
  var email = req.body.email;
  var password = req.body.password;

  connection.query(`INSERT INTO Users(FirstName, LastName, email, password)VALUES('${firstName}','${lastName}','${email}', '${password}');`, function (error, results, fields) {
    if (error) throw error;
    console.log('Result is: ', results);
  });
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})