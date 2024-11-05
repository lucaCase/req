import 'package:flutter/material.dart';
import 'package:req/components/tables/editable_table_row.dart';
import 'package:toastification/toastification.dart';

class KeyStoreController with ChangeNotifier {
  List<EditableTableRow> _rows = [
    EditableTableRow(
      key: UniqueKey(),
      onDelete: () {},
      keyController: TextEditingController(),
      valueController: TextEditingController(),
    ),
  ];

  List<EditableTableRow> get rows => _rows;

  void addRow() {
    _rows.add(
      EditableTableRow(
        key: UniqueKey(),
        onDelete: () => removeRow(_rows.length),
        keyController: TextEditingController(),
        valueController: TextEditingController(), // Placeholder
      ),
    );
    notifyListeners();
  }

  void addRowWithValues({required key, required value, required isEnabled}) {
    _rows.add(
      EditableTableRow(
        key: UniqueKey(),
        onDelete: () => removeRow(_rows.length),
        keyController: TextEditingController(text: key),
        valueController: TextEditingController(text: value),
        isEnabled: isEnabled,
      ),
    );
    notifyListeners();
  }

  void removeRow(int index) {
    if (_rows.length > 1) {
      _rows.removeAt(index);
      notifyListeners();
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
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
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

  void resetRows() {
    _rows = [
      EditableTableRow(
        key: UniqueKey(),
        onDelete: () {},
        keyController: TextEditingController(),
        valueController: TextEditingController(),
      ),
    ];
    notifyListeners();
  }
}
