import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/constants/todo_colors.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';
import 'package:todo_with_getx/view/auth/login/viewmodel/login_viewmodel.dart';
import 'package:todo_with_getx/view/widget/text_types.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginViewmodel>(
        init: LoginViewmodel(),
        builder: (LoginViewmodel controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Obx(() {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: context.allMediumPadding,
                              child: Placeholder(),
                            )),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: context.allMediumPadding,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildHeader(
                                    "Welcome, let's start",
                                    context,
                                    EdgeInsets.zero,
                                    context.textTheme.headline4?.copyWith(
                                      color: ColorConstants.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Fugiat eu magna nulla id enim veniam adipisicing sunt laborum cupidatat. Fugiat labore dolor enim duis. Labore qui reprehenderit laborum pariatur occaecat reprehenderit in aliqua Lorem laboris eu qui.",
                                    style: context.textTheme.bodyText1,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await _buildAlerDialog(
                                              context, controller);
                                        },
                                        child: Text("Let's Start")),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            }),
          );
        });
  }

  Future<dynamic> _buildAlerDialog(
      BuildContext context, LoginViewmodel controller) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sign Up"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onSaved: (String? value) async {
                      print(value);
                      await controller.addUser(value);
                    },
                    decoration: InputDecoration(labelText: "Name"),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState?.validate() != null) {
                            _formKey.currentState?.save();
                            Get.back();
                            Get.snackbar(
                              "Succesfuly",
                              "Registration Successful",
                              backgroundColor: ColorConstants.grey,
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.done),
                      label: Text("Save"))
                ],
              ),
            ),
          );
        });
  }
}
