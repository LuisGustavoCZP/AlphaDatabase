const database = require('./database');
const bcrypt = require('bcrypt');

//Registrar usuarios.
async function register (req, res) 
{
    const thisuser = 1;
    const { username, password, email, name, privilege=1 } = req.query;
    console.log(username, password, email, name, privilege);
    bcrypt.hash(password, 12, async (err, hash) =>
    {
        console.log(hash.length);
        const resp = await database.query(`INSERT INTO public.user (username, password, email, name, privilege, created_at, created_by) VALUES ($1, $2, $3, $4, $5, to_timestamp(${Date.now()} / 1000.0), ${thisuser});`, [username, hash, email, name, privilege])
        .catch(error => {
            console.log(error);//.detail
        }); //req.query["username"], hash
        
        //console.log("Registrou", resp);
    });
}

module.exports = register;