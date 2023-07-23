import 'package:flutter/material.dart';

class OverlayLoader extends StatelessWidget {
  final bool isLoading;

  const OverlayLoader({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Stack(
            children: [
              ModalBarrier(
                color: Colors.black.withOpacity(0.5),
                dismissible: false,
              ),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
