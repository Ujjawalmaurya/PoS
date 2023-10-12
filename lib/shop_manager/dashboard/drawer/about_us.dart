import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs(
      {super.key,
      this.para =
          "We're democratizing accounting, simplifying it, and putting it right in the retailer's palm. We believe that by making technology accessible and simplifying the way businesses do billing or accounting, we level the playing field and keep small businesses in business."});

  final String para;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About us")),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text("About us", style: Theme.of(context).textTheme.displayMedium),
            Text(
              para,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "- Team Paperlessly",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
