const admin = require("firebase-admin");
const keyJson = require("../env-key.json");

const firebaseAdminApp = admin.initializeApp({
    credential: admin.credential.cert(keyJson.firebaseKey)
});

async function validateAuthToken(token){
    try {
        const decodedIdToken = await firebaseAdminApp.auth().verifyIdToken(token);
        return decodedIdToken
    }catch (e){
        console.error('firebaseService:validateAuthToken: ',e);
        throw new Error(e.message)
    }
}

module.exports = {
    firebaseAdminApp,
    validateAuthToken,
}
