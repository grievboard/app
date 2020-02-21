var request = require('request');
var querystring = require('querystring');

module.exports = function (ref, data, callback) {
    var firebaseURL = ref.toString();
    var firebaseName = firebaseURL.match(/https:\/\/(.+)\.firebaseio.com/);
    var adminURL = 'https://admin.firebase.com/';


    if (!data.email) throw "Data object must have an 'email' field!";
    if (!data.password) throw "Data object must have an 'password' field!";
    if (!firebaseName) throw "Can't parse Firebase name from reference";

    firebaseName = firebaseName[1];
    var firebaseURL = 'https://' + firebaseName + '.firebaseio.com/';

    data.cli = "1.0.0"; // Fake a CLI version

    request.get(adminURL + 'account/login?' + querystring.stringify(data), function (error, response, body) {
        var data = JSON.parse(body);

        if (data.error) throw "Authentication failed! Check your email/password.";
        var adminToken = data.adminToken;
        var tokenURL = adminURL + 'firebase/' + firebaseName + '/token?token=' + adminToken;

        request.get(tokenURL, function (error, response, body) {
            var data = JSON.parse(body);
            authToken = data.personalToken;
            ref.authWithCustomToken(authToken, function (err, data) {
                callback(err, data, authToken);
            });
        });
    });
};
