import 'package:flutter/material.dart';

void showAddingSnackbar({
  required BuildContext context,
  required String songName,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.black,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            songName,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  );
}
