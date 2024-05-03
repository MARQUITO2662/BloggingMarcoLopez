import express from 'express'
import { createConnection } from 'mysql2/promise'
import dotenv from 'dotenv'
import { swaggerDocs } from './swaggerUi.js'

// Cargar las variables de entorno desde el archivo .env
dotenv.config()

// Crear la conexión a la base de datos
const connection = await createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  port: process.env.DB_PORT
})

const app = express()
const PORT = process.env.PORT || 3000

// Middleware para analizar solicitudes con formato JSON y de formularios HTML
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// Endpoint para obtener todos los usuarios
app.get('/api/users', async (req, res) => {
  try {
    const [rows] = await connection.query('SELECT `usuarios_id`, `usuarios_nombre`, `email` FROM `usuarios`')
    res.json(rows)
  } catch (error) {
    console.error('Error al obtener usuarios:', error)
    res.status(500).json({ error: 'Error al obtener usuarios' })
  }
})

// Endpoint para obtener un usuario por su ID
app.get('/api/users/:userId', async (req, res) => {
  const userId = req.params.userId
  try {
    const [rows] = await connection.query('SELECT `usuarios_id`, `usuarios_nombre`, `email` FROM `usuarios` WHERE `usuarios_id` = ?', [userId])
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Usuario no encontrado' })
    }
    res.json(rows[0])
  } catch (error) {
    console.error('Error al obtener usuario:', error)
    res.status(500).json({ error: 'Error al obtener usuario' })
  }
})

// Endpoint para crear un nuevo usuario
app.post('/api/users', async (req, res) => {
  const { usuariosNombre, email } = req.body
  try {
    const result = await connection.query('INSERT INTO `usuarios` (`usuarios_nombre`, `email`) VALUES (?, ?)', [usuariosNombre, email])
    res.status(201).json({ message: 'Usuario creado correctamente', userId: result[0].insertId })
  } catch (error) {
    console.error('Error al crear usuario:', error)
    res.status(500).json({ error: 'Error al crear usuario' })
  }
})

// Endpoint para actualizar los datos personales del usuario
app.put('/api/users/:userId', async (req, res) => {
  const userId = req.params.userId
  const { usuariosNombre, email } = req.body
  try {
    await connection.query('UPDATE `usuarios` SET `usuarios_nombre` = ?, `email` = ? WHERE `usuarios_id` = ?', [usuariosNombre, email, userId])
    res.json({ message: 'Datos de usuario actualizados correctamente' })
  } catch (error) {
    console.error('Error al actualizar datos de usuario:', error)
    res.status(500).json({ error: 'Error al actualizar datos de usuario' })
  }
})

// Endpoint para eliminar la cuenta de usuario
app.delete('/api/users/:userId', async (req, res) => {
  const userId = req.params.userId
  try {
    await connection.query('DELETE FROM `usuarios` WHERE `usuarios_id` = ?', [userId])
    res.json({ message: 'Cuenta de usuario eliminada correctamente' })
  } catch (error) {
    console.error('Error al eliminar cuenta de usuario:', error)
    res.status(500).json({ error: 'Error al eliminar cuenta de usuario' })
  }
})

// Endpoint para que el administrador vea todos los usuarios registrados
app.get('/api/admin/users', async (req, res) => {
  try {
    const [rows] = await connection.query('SELECT `usuarios_id`, `usuarios_nombre`, `email` FROM `usuarios`')
    res.json(rows)
  } catch (error) {
    console.error('Error al obtener usuarios:', error)
    res.status(500).json({ error: 'Error al obtener usuarios' })
  }
})

// Endpoint para obtener todas las publicaciones
app.get('/api/publicaciones', async (req, res) => {
  try {
    const [rows] = await connection.query('SELECT `publicaciones_id`, `titulo`, `contenido`, `usuarios_id` FROM `publicaciones`')
    res.json(rows)
  } catch (error) {
    console.error('Error al obtener publicaciones:', error)
    res.status(500).json({ error: 'Error al obtener publicaciones' })
  }
})

// Endpoint para obtener una publicación por su ID
app.get('/api/publicaciones/:publicacionId', async (req, res) => {
  const publicacionId = req.params.publicacionId
  try {
    const [rows] = await connection.query('SELECT `publicaciones_id`, `titulo`, `contenido`, `usuarios_id` FROM `publicaciones` WHERE `publicaciones_id` = ?', [publicacionId])
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Publicación no encontrada' })
    }
    res.json(rows[0])
  } catch (error) {
    console.error('Error al obtener publicación:', error)
    res.status(500).json({ error: 'Error al obtener publicación' })
  }
})

// Endpoint para crear una nueva publicación
app.post('/api/publicaciones', async (req, res) => {
  const { titulo, contenido, usuariosId } = req.body
  try {
    const result = await connection.query('INSERT INTO `publicaciones` (`titulo`, `contenido`, `usuarios_id`) VALUES (?, ?, ?)', [titulo, contenido, usuariosId])
    res.status(201).json({ message: 'Publicación creada correctamente', publicacionId: result[0].insertId })
  } catch (error) {
    console.error('Error al crear la publicación:', error)
    res.status(500).json({ error: 'Error al crear la publicación' })
  }
})

// Endpoint para actualizar una publicación
app.put('/api/publicaciones/:publicacionId', async (req, res) => {
  const publicacionId = req.params.publicacionId
  const { titulo, contenido } = req.body
  try {
    await connection.query('UPDATE `publicaciones` SET `titulo` = ?, `contenido` = ? WHERE `publicaciones_id` = ?', [titulo, contenido, publicacionId])
    res.json({ message: 'Publicación actualizada correctamente' })
  } catch (error) {
    console.error('Error al actualizar la publicación:', error)
    res.status(500).json({ error: 'Error al actualizar la publicación' })
  }
})

// Endpoint para eliminar una publicación
app.delete('/api/publicaciones/:publicacionId', async (req, res) => {
  const publicacionId = req.params.publicacionId
  try {
    await connection.query('DELETE FROM `publicaciones` WHERE `publicaciones_id` = ?', [publicacionId])
    res.json({ message: 'Publicación eliminada correctamente' })
  } catch (error) {
    console.error('Error al eliminar la publicación:', error)
    res.status(500).json({ error: 'Error al eliminar la publicación' })
  }
})

// Endpoint para obtener todos los comentarios de una publicación
app.get('/api/publicaciones/:publicacionId/comentarios', async (req, res) => {
  const publicacionId = req.params.publicacionId
  try {
    const [rows] = await connection.query('SELECT `comentario_id`, `comentario`, `usuario_id` FROM `comentarios` WHERE `publicacion_id` = ?', [publicacionId])
    res.json(rows)
  } catch (error) {
    console.error('Error al obtener comentarios de la publicación:', error)
    res.status(500).json({ error: 'Error al obtener comentarios de la publicación' })
  }
})

// Endpoint para obtener un comentario por su ID
app.get('/api/comentarios/:comentarioId', async (req, res) => {
  const comentarioId = req.params.comentarioId
  try {
    const [rows] = await connection.query('SELECT `comentario_id`, `comentario`, `usuario_id`, `publicacion_id` FROM `comentarios` WHERE `comentario_id` = ?', [comentarioId])
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Comentario no encontrado' })
    }
    res.json(rows[0])
  } catch (error) {
    console.error('Error al obtener comentario:', error)
    res.status(500).json({ error: 'Error al obtener comentario' })
  }
})

// Endpoint para actualizar un comentario
app.put('/api/comentarios/:comentarioId', async (req, res) => {
  const comentarioId = req.params.comentarioId
  const { comentario } = req.body
  try {
    await connection.query('UPDATE `comentarios` SET `comentario` = ? WHERE `comentario_id` = ?', [comentario, comentarioId])
    res.json({ message: 'Comentario actualizado correctamente' })
  } catch (error) {
    console.error('Error al actualizar el comentario:', error)
    res.status(500).json({ error: 'Error al actualizar el comentario' })
  }
})

// Endpoint para eliminar un comentario
app.delete('/api/comentarios/:comentarioId', async (req, res) => {
  const comentarioId = req.params.comentarioId
  try {
    await connection.query('DELETE FROM `comentarios` WHERE `comentario_id` = ?', [comentarioId])
    res.json({ message: 'Comentario eliminado correctamente' })
  } catch (error) {
    console.error('Error al eliminar el comentario:', error)
    res.status(500).json({ error: 'Error al eliminar el comentario' })
  }
})

// Endpoint para ver las publicaciones de otros usuarios
app.get('/api/publicaciones', async (req, res) => {
  try {
    const [rows] = await connection.query('SELECT * FROM `publicaciones`')
    res.json(rows)
  } catch (error) {
    console.error('Error al obtener publicaciones:', error)
    res.status(500).json({ error: 'Error al obtener publicaciones' })
  }
})

// Endpoint para filtrar publicaciones por categorías
app.get('/api/publicaciones/categorias/:categoriaId', async (req, res) => {
  const categoriaId = req.params.categoriaId
  try {
    const [rows] = await connection.query('SELECT * FROM `publicaciones` WHERE `categoria_id` = ?', [categoriaId])
    res.json(rows)
  } catch (error) {
    console.error('Error al obtener publicaciones por categoría:', error)
    res.status(500).json({ error: 'Error al obtener publicaciones por categoría' })
  }
})

// Endpoint para buscar publicaciones por título
app.get('/api/publicaciones/buscar/:titulo', async (req, res) => {
  const titulo = req.params.titulo
  try {
    const [rows] = await connection.query('SELECT * FROM `publicaciones` WHERE `titulo` LIKE ?', [`%${titulo}%`])
    res.json(rows)
  } catch (error) {
    console.error('Error al buscar publicaciones por título:', error)
    res.status(500).json({ error: 'Error al buscar publicaciones por título' })
  }
})
swaggerDocs(app)
app.listen(PORT, () => {
  console.log(`Servidor en ejecución en el puerto ${PORT}`)
})
