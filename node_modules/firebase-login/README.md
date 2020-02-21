firebase-login
==============

Allows your node applications to authenticate a Firebase reference using your Firebase account credentials.

*Note: This library is not related to Firebase's Simple Login email/password authentication. It allows you to log in with your Firebase account credentials, not a user's Simple Login email/password account.*

Installation
------------

Install via npm:

    npm install firebase-login


Example
-------
    var ref = new Firebase('https://<Your Firebase>.firebaseio.com');

    FirebaseLogin(ref, {
            email: "<Your Email>", 
            password: "<Your Password>"
        }, 
        function (error, data) {
            console.log(arguments);
        }
    );
    
Credits
-------
Development of this library is sponsored by [Rigidflame Consultants](http://www.rigidflame.com).
