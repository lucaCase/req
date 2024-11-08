import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../components/tables/editable_tables/editable_table_row.dart';

class ParamsKeyStoreController with ChangeNotifier {
  List<EditableTableRow> _rows = [
    EditableTableRow(
      index: 0,
      key: UniqueKey(),
      onDelete: () {},
      keyController: TextEditingController(),
      valueController: TextEditingController(),
      onEnable: () {},
      isEnabled: true,
    ),
  ];

  List<EditableTableRow> get rows => _rows;

  void addRow() {
    _rows.add(
      EditableTableRow(
        index: _rows.length,
        key: UniqueKey(),
        onDelete: () => removeRow(_rows.length),
        keyController: TextEditingController(),
        valueController: TextEditingController(),
        isEnabled: true,
        onEnable: () => toggleRow(_rows.length),
      ),
    );
    notifyListeners();
  }

  void addRowWithValues({required key, required value, required isEnabled}) {
    _rows.add(
      EditableTableRow(
        index: _rows.length,
        key: UniqueKey(),
        onDelete: () => removeRow(_rows.length),
        keyController: TextEditingController(text: key),
        valueController: TextEditingController(text: value),
        isEnabled: isEnabled,
        onEnable: () => toggleRow(_rows.length),
      ),
    );
    notifyListeners();
  }

  void removeRow(int index) {
    if (_rows.length > 1) {
      _rows.removeAt(index);
      notifyListeners();
    } else {
      if (_rows[0].keyController.text.isNotEmpty ||
          _rows[0].valueController.text.isNotEmpty) {
        _rows[0].valueController.text = "";
        _rows[0].keyController.text = "";
      } else {
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          alignment: Alignment.bottomRight,
          title: const Text(
            "Failed to push action",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          description: RichText(
            text: const TextSpan(
              text: "At least one row is required.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
          autoCloseDuration: const Duration(seconds: 4),
          showProgressBar: true,
          pauseOnHover: true,
          applyBlurEffect: true,
          animationDuration: const Duration(milliseconds: 300),
          closeButtonShowType: CloseButtonShowType.none,
          dragToClose: true,
          closeOnClick: true,
        );
      }
    }
  }

  void resetRows() {
    _rows = [
      EditableTableRow(
        index: 0,
        key: UniqueKey(),
        onDelete: () {},
        keyController: TextEditingController(),
        valueController: TextEditingController(),
        onEnable: () {},
      ),
    ];
    notifyListeners();
  }

  void toggleRow(int index) {
    _rows[index].isEnabled = !_rows[index].isEnabled;
    notifyListeners();
  }

  void reorderRows(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final row = _rows.removeAt(oldIndex);
    _rows.insert(newIndex, row);
    notifyListeners();
  }
}
