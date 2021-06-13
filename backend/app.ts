import express from 'express';
import mysql from 'mysql';

const app = express();

const port = 3000;

app.get('/', (req, res) => {
  var connection = mysql.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '1234',
    database: 'dhukuti'
  });

  connection.connect();

  connection.query('SELECT * FROM dhukuti.Users;', function (error, results, fields) {
    if (error) throw error;
    console.log('The solution is: ', results);
    res.send(results)
  });
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})