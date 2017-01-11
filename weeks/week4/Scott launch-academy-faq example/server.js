let express = require('express')
let questions = require('./src/constants/data')
let server = express()
let port = 3000

server.use((request, response, next) => {
  response.header("Access-Control-Allow-Origin", "*")
  response.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
  next()
})

server.get('/', (request, response) => {
  response.send('Express API server')
})

server.get('/api/v1/questions', (request, response) => {
  response.send(questions)
})

server.listen(port, '0.0.0.0', (error) => {
  if (error) {
    console.log(error)
  }

  console.info(`==> 🌎 Listening on port ${port}. Open http://0.0.0.0:${port}/ in your browser.`)
})
