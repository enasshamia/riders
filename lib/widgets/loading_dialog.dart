import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lhad_albiet_riders/widgets/progress_bar.dart';

class LoadingDialog extends StatelessWidget {

  final String? message;
  LoadingDialog({this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          const SizedBox(height: 10,),
          Text(message! + " , Please waite....."),
        ],
      ),

    );
  }
}
