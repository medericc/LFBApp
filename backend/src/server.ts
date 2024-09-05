import express, { Request, Response } from 'express';
import bodyParser from 'body-parser';
import cors from 'cors'; // Importer le middleware CORS
import db from './db'; // notre fichier db.ts
import { MysqlError } from 'mysql'; // Assurez-vous que ce type vient du bon module

const app = express();

app.use(cors()); // Activer CORS pour permettre les requêtes cross-origin
app.use(bodyParser.json());

// Interface pour typer une équipe
interface Team {
  id: number;
  name: string;
  league: string;
}

// Interface pour typer un joueur
interface Player {
  id: number;
  name: string;
  position: string;
  team_id: number;
}



// Obtenir les joueurs d'une équipe donnée par ID
app.get('/teams/:id/players', (req: Request, res: Response) => {
  const teamId = req.params.id;
  const query = 'SELECT * FROM player WHERE team_id = ?';
  
  db.query(query, [teamId], (err: MysqlError | null, results: Player[]) => {
    if (err) {
      res.status(500).send('Erreur lors de la récupération des joueurs');
    } else {
      res.json(results);
    }
  });
});

// Obtenir les équipes d'une ligue donnée par ID de ligue
app.get('/leagues/:leagueId/teams', (req: Request, res: Response) => {
  const leagueId = req.params.leagueId;
  const query = 'SELECT * FROM team WHERE league_id = ?';

  db.query(query, [leagueId], (err: MysqlError | null, results: Team[]) => {
    if (err) {
      res.status(500).send('Erreur lors de la récupération des équipes de la ligue');
    } else {
      res.json(results);
    }
  });
});

// Obtenir les équipes d'une ligue donnée par ID de ligue
// Liste des statistiques valides
const validStats = ['points', 'assists', 'rebonds', 'blocks', 'steals', 'evaluation', 'three_points', 'lancers'];

// Obtenir les meilleurs joueurs d'une ligue donnée pour une statistique spécifique
app.get('/:leagueId/top-players/:stat', (req: Request, res: Response) => {
  const leagueId = req.params.leagueId;
  const stat = req.params.stat;

  // Valider si la statistique demandée est valide
  if (!validStats.includes(stat)) {
    return res.status(400).json({ message: 'Statistique non valide' });
  }

  // Construire la requête SQL en toute sécurité
  const query = `
    SELECT player.name, player.forename, player.${stat}
    FROM player 
    JOIN team ON player.team_id = team.id
    WHERE team.league_id = ?
    ORDER BY player.${stat} DESC
    LIMIT 5
  `;

  // Exécuter la requête
  db.query(query, [leagueId], (err: MysqlError | null, results: any[]) => {
    if (err) {
      console.error('Erreur SQL:', err);
      return res.status(500).json({ message: 'Erreur lors de la récupération des meilleurs joueurs' });
    }
    
    // Renvoyer les résultats
    res.json(results);
  });
});




// Démarrer le serveur
app.listen(3000, '0.0.0.0', () => {
  console.log('Serveur démarré sur le port 3000');
});

const corsOptions = {
  origin: '*', // Permettre l'accès depuis n'importe quel domaine
  methods: 'GET,POST,PUT,DELETE',
  allowedHeaders: 'Content-Type,Authorization',
};
app.use(cors(corsOptions));

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});
