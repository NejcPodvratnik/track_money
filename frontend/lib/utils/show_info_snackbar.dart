import 'package:flutter/material.dart';

void showInfoSnackBar(BuildContext context, String info) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(info),
          ),
        )
      ],
    ),
    backgroundColor: Theme.of(context).primaryColor,
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
