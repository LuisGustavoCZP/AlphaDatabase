const database = require('./database');
//Checar usuarios usando nome ou id.
async function check (req, res) 
{
    //req.query('username' 'userid');
    const resp = await database.query('SELECT * FROM public.user', [])
    .catch(error => {
        console.log(error);//.detail
    });
    console.log("DB ", resp.rows);
    res.end();
}

module.exports = check;