const database = require('./database');
//Modificar nome usuarios.
async function modify (req, res) 
{
    const resp = await database.query('UPDATE public.user SET $1', []);
    console.log("DB ", resp.rows);
    res.end();
}

module.exports = modify;