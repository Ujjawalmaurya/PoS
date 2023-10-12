import 'package:flutter/material.dart';

class ShowLoading extends StatelessWidget {
  const ShowLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeCap: StrokeCap.round,
        strokeAlign: BorderSide.strokeAlignOutside,
        strokeWidth: 1,
      ),
    );
  }
}
