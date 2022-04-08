const database = require('./database');
//Modificar nome usuarios.
async function modify (req, res) 
{
    const thisuser = 1;
    const { username, password, email, name, privilege } = req.body;
    const resp = await database.query(`UPDATE public.user AS usr SET (username, password, email, name, privilege, updated_at, updated_by)=($2, $3, $4, $5, $6, to_timestamp(${Date.now()} / 1000.0), ${thisuser}) WHERE usr.id=$1;`, [req.params['userid'], username, password, email, name, privilege])
    .catch(error => {
        console.log(error);//.detail
    });
    console.log("DB ", resp.rows);
    res.end();
}

module.exports = modify;