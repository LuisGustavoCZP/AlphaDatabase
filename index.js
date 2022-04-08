const express = require('express');
const cookieParser = require('cookie-parser');
require('dotenv').config();

//CRUDE = INSERT, UPDATE, DELETE, SELECT
const visual = require('./modules/visual');
const login = require('./modules/login');
const session = require('./modules/session');
const register = require('./modules/register');
const del = require('./modules/delete');
const modify = require('./modules/modify');
const check = require('./modules/check');
const deletes = require('./modules/deleted');

const app = express();

app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true}));

app.post ("/login", login);

app.post ("/register", session.verify, register);

app.delete ("/delete/:username", session.verify, del);

app.put ("/modify/:username", session.verify, modify);

app.get ("/check", session.verify, check);

app.get ("/deleted", session.verify, deletes);

app.listen(process.env.PORT, () => {console.log(`O servidor foi iniciado em ${port}`)});