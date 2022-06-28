import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';

import '../../core/constants/todo_colors.dart';
import '../../core/theme/theme_data.dart';
import '../../model/todo_model.dart';
import '../home/viewmodel/home_viewmodel.dart';

Padding buildTodosCard(TodoModel? todoModel, BuildContext context) {
  HomeViewModel controller = Get.find<HomeViewModel>();
  Color color = ColorConstants
      .categoryColors[todoModel?.todoCategories?.categoryColorId ?? 0];

  return Padding(
    padding: context.horizontalMediumPadding,
    child: Card(
      child: Padding(
        padding: context.allVeryLowPadding,
        child: Row(
          children: [
            _buildCheckBox(color, context, todoModel, controller),
            _buildTodoTitle(todoModel, context),
            const Spacer(),
            PopupMenuButton(
              splashRadius: 16,
              icon: const Icon(Icons.settings, color: ColorConstants.grey),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                    onTap: () => deleteTodo(controller, todoModel),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

deleteTodo(HomeViewModel controller, todoModel) {
  controller.removeTodo(todoModel?.id);
}

Checkbox _buildCheckBox(
    Color color, BuildContext context, TodoModel? todoModel, controller) {
  return Checkbox(
    checkColor: Colors.white,
    fillColor: MaterialStateProperty.resolveWith(
        (states) => getColor(states, color, context)),
    value: todoModel?.isCompleted ?? false,
    onChanged: (bool? newValue) {
      todoModel?.isCompleted = newValue;
      print(todoModel?.id);
      controller.updateTodos();
    },
  );
}

AnimatedCrossFade _buildTodoTitle(TodoModel? todoModel, BuildContext context) {
  return AnimatedCrossFade(
    secondChild: Text(todoModel?.title ?? "",
        style: context.textTheme.bodyText1?.copyWith(
            decoration: TextDecoration.lineThrough,
            decorationColor: Colors.white,
            decorationThickness: 1.2,
            color: context.textTheme.bodyText1?.color?.withOpacity(.5))),
    firstChild: Text(
      todoModel?.title ?? "",
      style: context.textTheme.bodyText1,
    ),
    crossFadeState: todoModel?.isCompleted != true
        ? CrossFadeState.showFirst
        : CrossFadeState.showSecond,
    duration: const Duration(milliseconds: 500),
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
