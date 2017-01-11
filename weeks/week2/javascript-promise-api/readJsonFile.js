fs = require('fs')

let read = (filename) => {
  return new Promise((resolve, reject) => {
    fs.readFile(filename, 'utf8', (err, data) => {
      if (err) {
        reject(Error(err))
      } else {
        resolve(data)
      }
    })
  })
}

read('twitterData.json')
  .then((data) => { return JSON.parse(data) })
  .then((json) => { console.log(json) })
  .catch((err) => {
    console.log("Something went wrong.")
    console.log(err)
  })
