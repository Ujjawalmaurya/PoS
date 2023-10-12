import 'package:flutter/material.dart';

class ThemedWidget extends StatefulWidget {
  const ThemedWidget({super.key});

  @override
  State<ThemedWidget> createState() => _ThemedWidgetState();
}

class _ThemedWidgetState extends State<ThemedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "TAB One",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Elevated Button")),
          TextButton(onPressed: () {}, child: const Text("Text Button")),
          IconButton(onPressed: () {}, icon: const Icon(Icons.abc_outlined)),
          const TextField(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
