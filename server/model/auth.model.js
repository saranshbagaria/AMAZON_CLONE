/// package imports
const bcryptjs = require('bcryptjs');
const webToken = require('jsonwebtoken');
///local imports
const UserDb = require('./auth.moongo');


async function addUser(userData) {
    const existed = await findUser({
        user_: userData.user_name,
        email_: userData.email
    });
    if (existed) {
        console.error('client already existed');
        return null;
    }
    const hashedPassword = bcryptjs.hashSync(userData.password, 9);

    let user = new UserDb({
        email: userData.email,
        password: hashedPassword,
        user_name: userData.user_name
    });
    user = await user.save();
    return user;
}

async function findUser(userData) {
    const existing_user = await UserDb.findOne({
        user_name: userData.user_,
        email: userData.email_
    });

    return existing_user;
}

async function validateUser(userData) {
    let valid = false;
    const validUser = await UserDb.findOne({
        email: userData.email,
    })
    if (!validUser) {
        return {
            statusCode: 400,
            msg: "user with this email don't exist"
        };
    }
    valid = bcryptjs.compareSync(userData.password,
        validUser.password)
    if (!valid) {
        return {
            statusCode: 400,
            msg: "Incorrect Password"
        }
    }
/// json web token use to 
    const token = webToken.sign({ id: validUser._id }, "passwordKey");
    return {
        statusCode: 200,
        token,
        ...validUser._doc
    }
//... means destructuring 
}

async function tokenValidator(token){
    if(!token) return false;
    const verified = webToken.verify(token,"passwordKey")
    if(!verified) return false;
    const user = await UserDb.findById(verified.id);
    if(!user) return false;

    return true;
}
// here we are providing user data as per request 
// but before providing data we use a miidle ware whicj verify taken 
async function provideUserData(user){
    const userRes = await UserDb.findById(user);
    return userRes;
}

module.exports = {
    addUser,
    findUser,
    validateUser,
    tokenValidator,
    provideUserData
}