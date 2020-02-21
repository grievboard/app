var Firebase = require('firebase');
var FirebaseLogin = require('./index');

var ref = new Firebase('https://<Your Firebase>.firebaseio.com');

FirebaseLogin(ref, {email: "<Your Email>", password: "<Your Password>"}, function (error, data) {
    console.log(arguments);
});
