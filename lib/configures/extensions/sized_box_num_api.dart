import 'package:flutter/material.dart';

extension SizedBoxNumApi on num {
  SizedBox spaceHeight() => SizedBox(
    height: toDouble(),
  );

  SizedBox spaceWidth() => SizedBox(
    width: toDouble(),
  );
}
