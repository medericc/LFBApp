// server.js
const express = require('express');
const bodyParser = require('body-parser');
const db = require('./db'); // notre fichier db.js
const app = express();

app.use(bodyParser.json());

// Obtenir la liste des équipes
app.get('/teams', (req, res) => {
  const query = 'SELECT * FROM team';
  db.query(query, (err, results) => {
    if (err) {
      res.status(500).send('Erreur lors de la récupération des équipes');
    } else {
      res.json(results);
    }
  });
});

// Obtenir les joueurs d'une équipe donnée par ID
app.get('/teams/:id/players', (req, res) => {
  const teamId = req.params.id;
  const query = 'SELECT * FROM player WHERE team_id = ?';
  db.query(query, [teamId], (err, results) => {
    if (err) {
      res.status(500).send('Erreur lors de la récupération des joueurs');
    } else {
      res.json(results);
    }
  });
});

// Démarrer le serveur
app.listen(3000, () => {
  console.log('Serveur démarré sur le port 3000');
});
