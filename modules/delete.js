const database = require('./database');
//Deletar usuarios.
async function del (req, res) 
{
    const resp = await database.query('DELETE FROM public.user WHERE id=$1', [req.params['userid']]);
    console.log("DB ", resp.rows);
    res.end();
}

module.exports = del;