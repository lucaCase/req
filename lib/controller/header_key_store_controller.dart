import 'package:flutter/material.dart';
import 'package:req/components/tables/header_table/editable/editable_header_table_row.dart';
import 'package:toastification/toastification.dart';

class HeaderKeyStoreController with ChangeNotifier {
  List<EditableHeaderTableRow> _rows = [
    EditableHeaderTableRow(
      keyController: TextEditingController(),
      valueController: TextEditingController(),
      onEnable: () {},
      onDelete: () {},
      index: 0,
      key: UniqueKey(),
    ),
  ];

  List<EditableHeaderTableRow> get rows => _rows;

  void addRow() {
    _rows.add(
      EditableHeaderTableRow(
        keyController: TextEditingController(),
        valueController: TextEditingController(),
        onEnable: () {},
        onDelete: () {},
        index: _rows.length,
        key: UniqueKey(),
      ),
    );
    notifyListeners();
  }

  void addRowWithValues({required key, required value, required isEnabled}) {
    _rows.add(
      EditableHeaderTableRow(
        keyController: TextEditingController(text: key),
        valueController: TextEditingController(text: value),
        onEnable: () {},
        onDelete: () {},
        index: _rows.length,
        key: UniqueKey(),
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
      EditableHeaderTableRow(
        keyController: TextEditingController(),
        valueController: TextEditingController(),
        onEnable: () {},
        onDelete: () {},
        index: 0,
        key: UniqueKey(),
      ),
    ];
    notifyListeners();
  }

  void toggleRow(int index) {
    _rows[index].isEnabled = !_rows[index].isEnabled;
    notifyListeners();
  }

  void reorderRows(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final EditableHeaderTableRow item = _rows.removeAt(oldIndex);
    _rows.insert(newIndex, item);
    notifyListeners();
  }
}
