import express from 'express';
import dotenv from 'dotenv';
import mysql from 'mysql2/promise';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// Création d'un pool de connexions MySQL
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'rootpassword',
  database: process.env.DB_NAME || 'demo_binance',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

// Test de connexion à la base de données
pool.getConnection()
  .then(conn => {
    console.log('Connecté à la base MySQL');
    conn.release();
  })
  .catch(err => {
    console.error('Erreur de connexion à MySQL:', err);
  });

// Middleware pour parser le JSON
app.use(express.json());

// Route de test
app.get('/', (req, res) => {
  res.send('Hello, world! Backend avec MySQL est opérationnel.');
});

// Exemple de route pour récupérer des utilisateurs
app.get('/users', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM users');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la récupération des utilisateurs' });
  }
});

// Démarrage du serveur
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
