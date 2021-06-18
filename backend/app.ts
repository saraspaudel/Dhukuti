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
  console.log("Request is: ", req.body)
  var email = req.body.email;
  var password = req.body.password;

  connection.query('SELECT * FROM Users WHERE email = ?', [email], function (error, results, fields) {
    if (error) throw error;
    console.log('Users are : ', results);

    let user = results[0];
    
    if (user.length == 0) {
      res.status(401).send("Couldn't find user by that email address.");
      console.log("Email address not found.")
    } else if (user.password != password) {
      res.status(401).send("Username or password is incorrect.");
      console.log("Email right, password wrong")
    }
    else {
      console.log("User found")
      res.status(200).send({
        userId: user.userId,
        FirstName: user.FirstName,
        LastName: user.LastName,
        email: user.email
      });
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

app.get('/loanorder', (req, res) => {
  console.log("Called loan order get api");

  var loanId = req.query.loanId;

  let sql = `SELECT * FROM dhukuti.loanOrder WHERE loanId = ${loanId};`;

  connection.query(sql, (error, results, fields) => {
    console.log(results);
    res.status(200).send(results);
  })

})

app.post('/createLoan', async (req, res) => {
  var loanAmount = req.body.loanAmount;
  var totalParticipants = req.body.totalParticipants;
  var proposerUserId = req.body.proposerUserId;
  var loanFrequencyInDays = req.body.loanFrequencyInDays;
  var loanInterestRate = req.body.loanInterestRate;
  var loanId;

  console.log("Creating new loan");
  let sql = `INSERT INTO Loans(loanAmount, totalParticipants, proposerUserId, loanFrequencyInDays, loanInterestRate)VALUES('${loanAmount}','${totalParticipants}','${proposerUserId}', '${loanFrequencyInDays}', '${loanInterestRate}');`;
  connection.query(sql, function (error, results, fields) {
    if (error) { res.sendStatus(500); throw error };
    loanId = results.insertId;
    console.log("Loan created with id ", loanId);

    let increments = loanInterestRate / (totalParticipants/2);
    let interestRate = loanInterestRate;

    for (let turn = 1; turn != totalParticipants+1; turn++) {
      console.log("Generating loan orders");
      let sql = `INSERT INTO loanOrder (loanId, turn, interestRate) VALUES ('${loanId}', '${turn}', '${interestRate}');`
      connection.query(sql, function (error, results, fields) {
        if (error) { throw error };
        console.log("Inserted loan order: ", results);
      });
      interestRate =  interestRate - increments;
    }

    res.status(201).send({loanId: loanId});
  });

})

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})