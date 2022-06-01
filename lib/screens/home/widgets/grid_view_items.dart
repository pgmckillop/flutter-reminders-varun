import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/category/category.dart';

import '../../../models/reminder/reminder.dart';

class GridViewItems extends StatelessWidget {
  const GridViewItems({
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final allreminders = Provider.of<List<Reminder>>(context);
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 16 / 9,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      children: categories
          .map(
            (category) => Container(
              decoration: BoxDecoration(
                //color: Colors.black,
                color: const Color(0xFF1A191D),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        category.icon,
                        Text(
                          getCategoryCount(
                                  id: category.id, allReminders: allreminders)
                              .toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    Text(
                      category.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  int getCategoryCount({required id, List<Reminder>? allReminders}) {
    if (id == 'all' && allReminders != null) {
      return allReminders.length;
    }

    final categories =
        allReminders?.where((reminder) => reminder.categoryId == id);

    if (categories != null) {
      return categories.length;
    }

    return 0;
  }
}
