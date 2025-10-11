const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();
app.use(cors());
app.use(express.json());

// Ruta de prueba (para confirmar conexión)
app.get('/', (req, res) => {
  res.send('✅ Backend del Sistema de Tutorías funcionando correctamente.');
});

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

// Ruta de prueba MySQL
app.get('/api/dbtest', async (req, res) => {
  try {
    const [rows] = await db.query('SHOW DATABASES;');
    res.json({
      message: '✅ Conexión MySQL exitosa',
      databases: rows
    });
  } catch (error) {
    console.error('❌ Error en la consulta:', error);
    res.status(500).json({ message: 'Error conectando a MySQL', error: error.message });
  }
});

app.listen(3000, '0.0.0.0', () => {
  console.log("Servidor escuchando en el puerto 3000 (todas las interfaces)");
});