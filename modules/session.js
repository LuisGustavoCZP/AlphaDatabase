//Cria e checa a sessão do usuario
const crypto = require('crypto');

const sessions = {};
async function session (req, res, next) 
{
    //console.log();
    
    //sessions[crypto.randomUUID()]
    /* const sessao = {token:crypto.randomUUID(), userid:0};
    sessoes[sessao.token] = sessao;
    const userid = sessoes[sessao.token].userid;
    console.log(users[userid].name); */
    next();
}

module.exports = session;
