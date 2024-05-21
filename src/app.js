const express = require('express');
const app = express();
const PORT = process.env['PORT'] || 8080;
const DEBUG = process.env['DEBUG'] || false;

app.get('/', (req, res) => {
  res.json({ "message": 'Hello World!'});
});

app.get('/foo', (req, res) => {
  if (DEBUG)
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
  if (DEBUG)
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

app.listen(PORT, () => {
  console.log(`Example app listening on port ${PORT}`);
});