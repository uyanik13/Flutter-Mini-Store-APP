library dropdown_formfield;

import 'package:flutter/material.dart';


class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final Icon icon;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final List item;
  final String textField;
  final String valueField;
  final Function onChanged;
  final bool filled;

  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      bool autoValidate = false,
      this.titleText = '',
      this.hintText = '',
      this.required = false,
      this.errorText = '',
      this.value,
      this.dataSource,
      this.item,
      this.textField,
      this.valueField,
      this.icon,
      this.onChanged,
      this.filled = true})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autoValidate,
          initialValue: value == '' ? null : value,
          builder: (FormFieldState<dynamic> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 25, 0),
                      labelText: titleText,
                        labelStyle:TextStyle(color: Color(0xff9785B7)),
                      prefixIcon: icon,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        hint: Text(
                          hintText,
                          style: TextStyle(color: Color(0xff9785B7)),
                        ),
                        value: value == '' ? null : value,
                        onChanged: (dynamic newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items:item,
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(color: Color(0xff9785B7), fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}
