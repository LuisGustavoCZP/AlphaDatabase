const database = require('./database');
//Logar com nome e senha usuarios.
async function login (req, res) 
{
    const resp = await database.query('SELECT * FROM public.user WHERE username=$1', [req.body["username"]])
    .catch(error => {
        console.log(error);//.detail
    }); //AND password=$2
    //Encontrou usuario?
    if(res.rows.length > 0) 
    {
        const pass = req.body["password"];
        const user = res.rows[0];
        
    }
    //Não encontrou usuario
    else 
    {

    }
}

module.exports = login;


/* const users = [{name:"luis", pass:""}];
const sessoes = {};

 */
/* const crypto = require('crypto');
const dotenv = require('dotenv');
const bcrypt = require('bcrypt'); */