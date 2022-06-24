import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';
import 'package:todo_with_getx/view/form/view/todo_form_view.dart';

import '../../../core/constants/todo_colors.dart';
import '../../../core/enum/todo_enum.dart';
import '../viewmodel/home_viewmodel.dart';

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
            onPressed: () => Get.to(TodoFormView()),
            child: const Icon(Icons.add_rounded),
          ),
          appBar: _buildAppBar(),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeHeader(welcomeText, textTheme, context),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: _buildCategoriesColumn(categories, textTheme, context),
              ),
              SliverAppBar(
                pinned: true,
                backgroundColor: ColorConstants.lightBlue,
                elevation: 10,
                titleSpacing: 0,
                title: _buildHeader(todaysTask, textTheme, context),
              ),
              SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildTodosList(value1, textTheme, context);
                },
              ))
            ],
          ),
        );
      },
    );
  }

  Padding _buildTodosList(
      bool value1, TextTheme textTheme, BuildContext context) {
    return Padding(
      padding: context.horizontalMediumPadding,
      child: Card(
        child: Padding(
          padding: context.allVeryLowPadding,
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
  }

  Padding _buildWelcomeHeader(
      String welcomeText, TextTheme textTheme, BuildContext context) {
    return Padding(
      padding: context.horizontalMediumPadding + context.verticalNormalPadding,
      child: Text(
        welcomeText,
        style: textTheme.headline1,
      ),
    );
  }

  Column _buildCategoriesColumn(
      String categories, TextTheme textTheme, BuildContext context) {
    //TODO buraya sonra gel hive ile çektiğin veriye göre çek ve kategorileri oluştur
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(categories, textTheme, context),
        SizedBox(
          height: 0,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 200,
                child: _buildCategoriesCard(textTheme),
              );
            },
          ),
        )
      ],
    );
  }

  Padding _buildHeader(
      String title, TextTheme textTheme, BuildContext context) {
    return Padding(
      padding: context.horizontalMediumPadding + context.verticalLowPadding,
      child: Text(
        title.toUpperCase(),
        style: textTheme.headline5,
      ),
    );
  }

  Card _buildCategoriesCard(TextTheme textTheme) {
    //  TODO buraya gel yorum text altını dzenle
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
              " todoCategories.name.capitalize ",
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
