// db.js
const mysql = require('mysql');

const connection = mysql.createConnection({
  host: 'localhost',    // ou l'adresse de ton serveur MySQL
  user: 'root',         // ton utilisateur MySQL
  password: '',         // ton mot de passe
  database: 'statslfb' // remplace par le nom de ta base de données
});

connection.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à la base de données :', err);
    return;
  }
  console.log('Connecté à la base de données MySQL');
});

module.exports = connection;
