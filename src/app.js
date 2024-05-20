const express = require('express')
const app = express()
const port = 8080

app.get('/', (req, res) => {
  res.json({ "message": 'Hello World!'});
});

app.get('/foo', (req, res) => {
  console.log("This is a foo request");
  res.json(
    {
      "headers": req.headers,
      "message": "This is some good foo",
      "fooattrs": [
        {
          "one": "fooone",
          "two": "footwo",
          "three": "foothree",
        }
      ]
    }
  );
});

app.get('/bar', (req, res) => {
  console.log("This is a bar request");
  res.json(
    {
      "headers": req.headers,
      "message": "This is very bar",
      "barattrs": [
        {
          "one": "barone",
          "two": "bartwo",
          "three": "barthree",
        }
      ]
    }
  );
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
