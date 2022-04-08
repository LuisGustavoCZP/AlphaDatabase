const database = require('./database');

//Checar usuarios usando nome ou id.
async function deleted (req, res) 
{
    const response = await database.query('SELECT * FROM public.deleted_user')
    .then(resp => {
        console.log("Check ", resp.rows);
        res.send(resp.rows);
    })
    .catch(error => {
        console.log(error);//.detail
        res.send(error.detail);
    });
    //
}

module.exports = deleted;