const crypto = require('crypto');
const dotenv = require('dotenv');
const bcrypt = require('bcrypt');

const users = [{name:"luis", pass:""}];
const sessoes = {};

const sessao = {token:crypto.randomUUID(), userid:0};
sessoes[sessao.token] = sessao;
const userid = sessoes[sessao.token].userid;
console.log(users[userid].name);