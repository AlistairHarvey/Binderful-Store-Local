import 'package:binderful_store/constants/routes.dart';
import 'package:binderful_store/screens/homepage/widgets/home_menu_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ColoredBox(
              color: Colors.blue,
              child: Row(
                children: [
                  // TODO Make this able to toggle between screens
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Text(
                      'Binderful Store',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        // TODO find a way to build this.
                        HomeMenuItem(
                          title: 'Add Products',
                          onTap: () => RouteNames.addCards.pushNamed(context),
                        ),
                        HomeMenuItem(
                          title: 'Add New Set',
                          onTap: () => RouteNames.newSet.pushNamed(context),
                          isWorkInProgress: true,
                        ),
                        HomeMenuItem(
                          title: 'Update Sets',
                          onTap: () => RouteNames.updateSets.pushNamed(context),
                        ),
                        HomeMenuItem(
                          title: 'Update Prices',
                          onTap: () =>
                              RouteNames.updatePrices.pushNamed(context),
                          isWorkInProgress: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
