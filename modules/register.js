const database = require('./database');
const bcrypt = require('bcrypt');

//Registrar usuarios.
async function register (req, res) 
{
    const { username, password, email, name } = req.query;
    console.log(username, password, email, name);
    bcrypt.hash(password, 12, async (err, hash) =>
    {
        console.log(hash.length);
        const resp = await database.query(`INSERT INTO public.user (username, password, email, name, privilege, created_at, created_by) VALUES ($1, $2, $3, $4, 1, to_timestamp(${Date.now()} / 1000.0), -1);`, [username, hash, email, name])
        .catch(error => {
            console.log(error);//.detail
        }); //req.query["username"], hash
        
        //console.log("Registrou", resp);
    });
}

module.exports = register;