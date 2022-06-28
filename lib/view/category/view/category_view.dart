import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/view/category/viewmodel/category_viewmodel.dart';
import 'package:todo_with_getx/view/home/view/home_view.dart';
import 'package:todo_with_getx/view/home/viewmodel/home_viewmodel.dart';
import 'package:todo_with_getx/view/widget/text_types.dart';
import 'package:todo_with_getx/view/widget/todo_card.dart';

import '../../form/view/todo_form_view.dart';

class CategoryView extends StatelessWidget {
  CategoryView({Key? key, required this.category}) : super(key: key);
  final TodoCategories? category;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (HomeViewModel controller) {
          String? title = "${category?.categoryName ?? ""} tasks";
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => Get.delete<HomeViewModel>().then(
                  (value) => Get.to(() => TodoFormView(page: HomeView()))),
              child: const Icon(Icons.add_rounded),
            ),
            appBar: AppBar(
              title: Text((category?.categoryName?.capitalize ?? "")),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () => Get.delete<CategoryViewmodel>()
                      .then((value) => Get.to(() => HomeView())),
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: buildHeader(title, context),
                ),
                buildLoading(controller, _categoryTasks(controller)),
              ],
            ),
          );
        });
  }

  SliverList _categoryTasks(HomeViewModel controller) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      childCount:
           controller.categoryTodos?.length,
      (context, index) {
        return buildTodosCard(
            controller.categoryTodos?.reversed.toList()[index], context);
      },
    ));
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
}
