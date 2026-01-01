import 'package:flutter/material.dart';

showBottomSheetWidget({
  required Widget child,
  required BuildContext navContext,
  String? title,
  String? subtitle,
  bool hideSheetHeader = false,
}) {
  final context = navContext;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hideSheetHeader) ...[
            const HeaderBottomSheet(),
            const SizedBox(height: 16),
          ],
          const SizedBox(height: 16),
          if (title != null)
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: child,
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

class HeaderBottomSheet extends StatelessWidget {
  const HeaderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 5,
          margin: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

void showBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        snap: true,
        snapSizes: const [0.5, 0.6, 0.8, 0.9],
        expand: false,
        maxChildSize: 0.9,
        minChildSize: 0.1,
        initialChildSize: 0.3,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: List.generate(50, (index) => const Text('Test')),
              ),
            ),
          );
        },
      );
    },
  );
}
