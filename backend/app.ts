import express from 'express';
import mysql from 'mysql';

const app = express();

app.use(express.json()); //Used to parse JSON bodies
app.use(express.urlencoded({extended: true})); //Parse URL-encoded bodies

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

  var firstName = req.body.FirstName;
  var lastName = req.body.LastName;
  var email = req.body.email;
  var password = req.body.password;
  
  connection.query('SELECT email FROM Users WHERE email = ?', [email], (err, result) => {
    console.log(result);
    if (result.length === 1) {
      res.status(409).send("That email address already exists.");
    } else {
      connection.query(`INSERT INTO Users(FirstName, LastName, email, password)VALUES('${firstName}','${lastName}','${email}', '${password}');`, function (error, results, fields) {
        if (error) throw error;
        console.log("Insert into results ", results);
        res.status(201).send({"userId": results.insertId});
      });
    }
    if (err) throw err;
  });
})

app.get('/loans', (req, res) => {
  console.log("Called loans");
  let sql = 'SELECT * FROM dhukuti.Loans;';
  connection.query(sql, function (error, results, fields) {
    console.log(results)
    res.send(results);
  });
})

app.post('/createLoan', (req, res) => {
  var loanAmount = req.body.loanAmount;
  var totalParticipants = req.body.totalParticipants;
  var proposerUserId = req.body.proposerUserId;
  var loanFrequencyInDays = req.body.loanFrequencyInDays;
  var loanInterestRate = req.body.loanInterestRate;

  console.log("Creating new loan");
  let sql = `INSERT INTO Loans(loanAmount, totalParticipants, proposerUserId, loanFrequencyInDays, loanInterestRate)VALUES('${loanAmount}','${totalParticipants}','${proposerUserId}', '${loanFrequencyInDays}', '${loanInterestRate}');`;
  connection.query(sql, function (error, results, fields) {
    if (error) { res.sendStatus(500); throw error };
    res.sendStatus(200);
  });

  for (let turn = 0; turn < totalParticipants; turn++) {
    
    
  }

})

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})