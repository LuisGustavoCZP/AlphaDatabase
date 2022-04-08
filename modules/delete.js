const database = require('./database');
//Deletar usuarios.
async function del (req, res) 
{
    const thisuser = 1;
    const resp = await database.query(`UPDATE public.user AS usr SET (deleted_at, deleted_by) = ('2022-04-07 03:03:00', ${thisuser}) WHERE id=$1; DELETE FROM public.user WHERE id=$1;`, [req.params['userid']])
    .catch(error => {
        console.log(error);//.detail
    });
    console.log("DB ", resp.rows);
    res.end();
}

module.exports = del;