import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFieldView extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? errorText;
  final bool isObscureText, isAllowTopTitleView;
  final EdgeInsetsGeometry padding;
  final Function(String)? onChanged;
  final VoidCallback? toggleObscure;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final double textFieldBoxHeight;

  const CommonTextFieldView({
    Key? key,
    this.hintText = '',
    this.isObscureText = false,
    this.padding = const EdgeInsets.only(),
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isAllowTopTitleView = true,
    this.errorText,
    required this.labelText,
    required this.controller,
    this.toggleObscure,
    this.textFieldBoxHeight = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            labelText,
            style: const TextStyle(
                fontFamily: 'Jameel Noori Nastaleeq', fontSize: 30),
          ),
          const SizedBox(height: 10),
          Container(
            height: textFieldBoxHeight,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: Center(
              child: TextField(
                controller: controller,
                maxLines: 1,
                onChanged: onChanged,
                style: const TextStyle(color: Colors.green, fontSize: 30),
                textAlign: TextAlign.center,
                obscureText: isObscureText,
                cursorColor: Colors.green,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                decoration: InputDecoration(
                  hintText: hintText,
                  filled: true,
                  suffixIcon: toggleObscure != null
                      ? isObscureText
                          ? IconButton(
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              onPressed: toggleObscure,
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: toggleObscure,
                            )
                      : null,
                  labelText: null,
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                keyboardType: keyboardType,
              ),
            ),
          ),
          if (errorText != null && errorText != '')
            Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 16, top: 4, bottom: 4),
              child: Text(
                errorText ?? "",
                style: TextStyle(
                  color: Colors.red.shade200,
                  fontSize: 16,
                ),
              ),
            )
        ],
      ),
    );
  }
}
