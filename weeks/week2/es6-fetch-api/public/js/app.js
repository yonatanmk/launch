// app.js
// change the following code to append list elements for each book

// let data = {
//   book: {
//     name: 'Harry Potter'
//   }
// };
// let jsonStringData = JSON.stringify(data);
//
// fetch('http://localhost:4567/books.json', {
//   method: 'post',
//   body: jsonStringData
//   })
//   .then(response => {
//     if (response.ok) {
//       return response;
//     } else {
//       let errorMessage = `${response.status} (${response.statusText})`,
//           error = new Error(errorMessage);
//       throw(error);
//     }
//   })
//   .then(response => response.text())
//   .then(body => {
//     console.log(body);
//     let bodyParsed = JSON.parse(body);
//     console.log(bodyParsed);
//   })
//   .catch(error => console.error(`Error in fetch: ${error.message}`));
fetch('http://localhost:4567/books.json')
  .then(response => {
    if (response.ok) {
      return response;
    } else {
      let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage);
      throw(error);
    }
  })
  .then(response => response.text())
  .then(body => {
    console.log(body);
    let bodyParsed = JSON.parse(body);
    console.log(bodyParsed);
    $(document).ready(function(){
      for (let book of bodyParsed.books) {
        $('#books').append(`<li>${book.name}</li>`);
      }
    });
  })
