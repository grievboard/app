//import 'dart:js';

import 'package:flutter/material.dart';
// import 'package:progress_dialog/progress_dialog.dart';

// ProgressDialog pr ;

Container circularProgress() {
  return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10.0),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.purple),
      ));
}

Container linearProgress() {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.purple),
    ),
  );
}

    //   progressdailog(){
    //    return 
    //       pr.show();
       
    //     ProgressDialog(context).update("posting");

    //  }
 
