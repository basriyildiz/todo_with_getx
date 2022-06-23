import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/constants/todo_colors.dart';
import 'package:todo_with_getx/enum/todo_enum.dart';
import 'package:todo_with_getx/extension/string_extension.dart';
import 'package:todo_with_getx/view/todo_form_view.dart';
import 'package:todo_with_getx/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? value1 = false;
    String welcomeText = "What's up, Olivia!";
    String categories = "Categories";
    String todaysTask = "Today's tasks";
    var textTheme = Theme.of(context).textTheme;
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (HomeViewModel controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(TodoFormView());
            },
            child: const Icon(Icons.add_rounded),
          ),
          appBar: _buildAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Text(
                  welcomeText,
                  style: textTheme.headline1,
                ),
              ),
              _buildCategoriesColumn(categories, textTheme),
              const SizedBox(height: 20),
              _buildHeader(todaysTask, textTheme),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 1),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  value: value1,
                                  onChanged: (bool? newValue) {},
                                ),
                                Text(
                                  "SDasdas asd sa dsa d",
                                  style: textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }

  Column _buildCategoriesColumn(String categories, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(categories, textTheme),
        SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            scrollDirection: Axis.horizontal,
            itemCount: TodoCategories.values.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 200,
                child: _buildCategoriesCard(
                    textTheme, TodoCategories.values[index]),
              );
            },
          ),
        )
      ],
    );
  }

  Padding _buildHeader(String title, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        title.toUpperCase(),
        style: textTheme.headline5,
      ),
    );
  }

  Card _buildCategoriesCard(
      TextTheme textTheme, TodoCategories todoCategories) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "40 tasks",
              style: textTheme.bodySmall?.copyWith(
                color: ColorConstants.grey,
              ),
            ),
            Text(
              todoCategories.name,
              style: textTheme.headline4,
            ),
            SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.all(const Radius.circular(50)),
              child: Container(
                height: 5,
                child: LinearProgressIndicator(
                  backgroundColor: ColorConstants.darkGrey.withOpacity(.8),
                  color: ColorConstants.pink,
                  value: .5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_rounded),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}
