import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdatePricesScreen extends StatelessWidget {
  const UpdatePricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This screen is not yet ready',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Here you will be able to import your stock list as a CSV\n'
                'file then scan our database for prices against stock.\n'
                'This will allow bulk price updating.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: context.pop,
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
