const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();
app.use(cors());
app.use(express.json());

// Ruta de prueba: leer todos los estudiantes (tabla ejemplo)
app.get('/api/estudiantes', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM estudiante'); // Cambiar 'estudiante' por tu tabla
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al obtener los datos' });
  }
});

// Ruta de prueba: agregar estudiante
app.post('/api/estudiantes', async (req, res) => {
  const { nombre, correo } = req.body;
  try {
    const [result] = await db.query(
      'INSERT INTO estudiante (nombre, correo) VALUES (?, ?)',
      [nombre, correo]
    );
    res.json({ id: result.insertId, nombre, correo });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al agregar estudiante' });
  }
});

app.listen(3001, () => {
  console.log('Servidor backend en puerto 3001');
});
