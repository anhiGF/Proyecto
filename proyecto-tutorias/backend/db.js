// backend/db.js
const mysql = require('mysql2');

const pool = mysql.createPool({
  host: 'db',          // Nombre del servicio MySQL en docker-compose
  user: 'user',        // Usuario definido en docker-compose
  password: 'userpass',// Contraseña
  database: 'tutoria', // Base de datos creada
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

module.exports = pool.promise();
