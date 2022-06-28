import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/view/category/view/category_view.dart';
import 'package:todo_with_getx/view/category/viewmodel/category_viewmodel.dart';
import 'package:todo_with_getx/view/form/view/todo_form_view.dart';
import 'package:todo_with_getx/view/widget/todo_card.dart';

import '../../../core/constants/todo_colors.dart';
import '../../../model/todo_model.dart';
import '../../widget/appBar/custom_app_bar.dart';
import '../../widget/text_types.dart';
import '../viewmodel/card_animation.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String welcomeText = "What's up, Olivia!";
    String todaysTask = "Today's tasks";
    var textTheme = Theme.of(context).textTheme;

    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (HomeViewModel controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.delete<HomeViewModel>()
                .then((value) => Get.to(() => TodoFormView(
                      page: HomeView(),
                    ))),
            child: const Icon(Icons.add_rounded),
          ),
          appBar: buildAppBar(),
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
              buildLoading(
                  controller, _categoriesColumnSliver(controller, context)),
              _sliverAppBar(todaysTask, context),
              buildLoading(controller, _todayTasksSliver(controller, context))
            ],
          ),
        );
      },
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

  SliverToBoxAdapter _categoriesColumnSliver(
      HomeViewModel controller, BuildContext context) {
    return SliverToBoxAdapter(
      child: _buildCategoriesColumn(controller, context),
    );
  }

  SliverAppBar _sliverAppBar(String todaysTask, BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: ColorConstants.lightBlue,
      elevation: 10,
      titleSpacing: 0,
      title: buildHeader(todaysTask, context),
    );
  }

  SliverList _todayTasksSliver(HomeViewModel controller, BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: controller.isLoading.value ? 0 : controller.todos?.length,
        (context, index) {
          return buildTodosCard(
              controller.todos?.reversed.toList()[index], context);
        },
      ),
    );
  }
}

Column _buildCategoriesColumn(HomeViewModel controller, BuildContext context) {
  String categories = "Categories";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildHeader(categories, context),
      SizedBox(
        height: 100,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            TodoCategories? category = controller.categories?[index];
            int? taskNumber =
                controller.getTodosByCategory(category?.id)?.length;

            return Visibility(
              visible: taskNumber != null
                  ? taskNumber > 0
                      ? true
                      : false
                  : false,
              child: SizedBox(
                width: 200,
                child: _buildCategoriesCard(
                    category, context, controller, taskNumber),
              ),
            );
          },
        ),
      )
    ],
  );
}

InkWell _buildCategoriesCard(TodoCategories? category, BuildContext context,
    HomeViewModel controller, int? taskNumber) {
  List<TodoModel>? categoryTodos = controller.getTodosByCategory(category?.id);

  double? value = _calculateCardStatus(categoryTodos);
  return InkWell(
    onTap: () {
      controller.categoryTodos = categoryTodos;
      Get.to(CategoryView(category: category), preventDuplicates: false);
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${taskNumber == null ? "0" : taskNumber.toString()} task",
              style: context.textTheme.bodySmall?.copyWith(
                color: ColorConstants.grey,
              ),
            ),
            Text(
              (category?.categoryName)?.capitalize ?? "",
              style: context.textTheme.headline4,
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: SizedBox(
                height: 5,
                child: LinearProgressIndicator(
                  backgroundColor: ColorConstants.darkGrey.withOpacity(.8),
                  color: ColorConstants
                      .categoryColors[category?.categoryColorId ?? 0],
                  value: value ?? .5,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

double? _calculateCardStatus(List<TodoModel>? categoryTodos) {
  int? completedTodosLength = categoryTodos
      ?.where((element) => element.isCompleted == true)
      .toList()
      .length;
  double? answer;
  try {
    answer = completedTodosLength! / (categoryTodos?.length.toInt() ?? 0);
  } catch (e) {
    print("hata");
    return answer;
  }
  return answer;
}

Obx buildLoading(HomeViewModel controller, var sliverWidget) {
  return Obx(
    () {
      if (controller.isLoading.value) {
        return const SliverToBoxAdapter(
            child: Center(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: CircularProgressIndicator(),
          ),
        ));
      } else {
        return sliverWidget;
      }
    },
  );
}
