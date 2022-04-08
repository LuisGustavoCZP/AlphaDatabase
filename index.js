const express = require('express');
const cookieParser = require('cookie-parser');
require('dotenv').config();

const port = process.env.PORT;
//CRUDE = INSERT, UPDATE, DELETE, SELECT
const visual = require('./modules/visual');
const login = require('./modules/login');
const session = require('./modules/session');
const register = require('./modules/register');
const del = require('./modules/delete');
const modify = require('./modules/modify');
const check = require('./modules/check');

const app = express();

app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true}));

app.post ("/login", login);

app.get ("/register", session, register);

app.delete ("/delete", session, del);

app.put ("/modify", session, modify);

app.get ("/check", session, check);

app.listen(port, () => {console.log(`O servidor foi iniciado em ${port}`)});