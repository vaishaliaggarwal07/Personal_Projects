

const firebase = require("firebase-admin");
const User = require("../models/userModel");
var serviceAccount = require("../config/dhakkadService.json");


const firebaseApp = firebase.initializeApp({
    credential: firebase.credential.cert(serviceAccount)
  });
  

exports.loginViaFirebaseToken = async (body = null) => {
    // Decoding Token
    const decodedToken = await firebaseApp.auth().verifyIdToken(body.token, true);
    console.log('response');
    // console.log(JSON.stringify(decodedToken, null, 4));
    // const decodedToken = {email:'jatinsonip5@gmail.com',phone_number:'',displayName:'Pankaj', uid:'qUaHib5OpzX5nRvrha1BG6IHs4O2'}
    // Getting User Info By Firebase Id
    const response = await User.find({'firebaseId':decodedToken.uid})


    if (response.length==0) {
        var user = decodedToken
        console.log(user);
        // create new user
        var newUser = {
            "firebaseId":user["uid"],
            "userName": user["email"].split("@")[0],
            "email": user["email"],
            "status": "Active",
            "userType": body ? body.userType:"user",
        }
        let createdUser = User.create(newUser)
        return createdUser;
    }
    

    return response

}