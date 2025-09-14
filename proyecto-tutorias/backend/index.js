const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());

app.get('/api', (req, res) => {
  res.json({ mensaje: '¡Hola desde el backend!' });
});

app.listen(3001, () => {
  console.log('Servidor backend en puerto 3001');
});
