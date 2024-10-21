import 'package:flutter/material.dart';

extension SizedBoxDoubleExtension on double {

  SizedBox get hspace {
    return SizedBox(width: this);
  }

  SizedBox get vspace {
    return SizedBox(height: this);
  }
}

extension SizedBoxIntExtension on int {

  SizedBox get hspace {
    return toDouble().hspace;
  }

  SizedBox get vspace {
    return toDouble().vspace;
  }
}