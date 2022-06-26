import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/view/form/view/todo_form_view.dart';

import '../../../core/constants/todo_colors.dart';
import '../../../model/todo_model.dart';
import '../../widget/appBar/custom_app_bar.dart';
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
                .then((value) => Get.to(() => TodoFormView())),
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
      title: _buildHeader(todaysTask, context),
    );
  }

  SliverList _todayTasksSliver(HomeViewModel controller, BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: controller.isLoading.value ? 0 : controller.todos?.length,
        (context, index) {
          return _buildTodosList(controller.todos?.reversed.toList()[index],
              context.textTheme, context, controller);
        },
      ),
    );
  }

  Padding _buildTodosList(TodoModel? todoModel, TextTheme textTheme,
      BuildContext context, HomeViewModel controller) {
    Color color = ColorConstants
        .categoryColors[todoModel?.todoCategories?.categoryColorId ?? 0];

    return Padding(
      padding: context.horizontalMediumPadding,
      child: Card(
        child: Padding(
          padding: context.allVeryLowPadding,
          child: Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(
                    (states) => getColor(states, color, context)),
                value: todoModel?.isCompleted ?? false,
                onChanged: (bool? newValue) {
                  todoModel?.isCompleted = newValue;
                  print(todoModel?.id);
                  controller.updateTodos();
                },
              ),
              Text(
                todoModel?.title ?? "",
                style: textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildCategoriesColumn(
      HomeViewModel controller, BuildContext context) {
    String categories = "Categories";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(categories, context),
        SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 200,
                child: _buildCategoriesCard(
                    controller.categories?[index], context, controller),
              );
            },
          ),
        )
      ],
    );
  }

  Padding _buildHeader(String title, BuildContext context) {
    return Padding(
      padding: context.horizontalMediumPadding + context.verticalLowPadding,
      child: Text(
        title.toUpperCase(),
        style: context.textTheme.headline5,
      ),
    );
  }

  Card _buildCategoriesCard(TodoCategories? category, BuildContext context,
      HomeViewModel controller) {
    int? taskNumber = controller.getTodosByCategory(category?.id)?.length;
    return Card(
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
                  value: .5,
                ),
              ),
            )
          ],
        ),
      ),
    );
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

  Color getColor(
      Set<MaterialState> states, Color? modelColor, BuildContext context) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      //  State'lere göre fill color burdan değiştirebilirsin
    };
    if (states.any(interactiveStates.contains)) {
      return modelColor ?? ColorConstants.pink;
    }
    return modelColor ?? ColorConstants.pink;
  }
}
