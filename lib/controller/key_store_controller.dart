import 'package:flutter/cupertino.dart';
import 'package:req/components/tables/editable_table_row.dart';

class KeyStoreController with ChangeNotifier {
  List<EditableTableRow> _rows = [
    EditableTableRow(),
  ];

  List<EditableTableRow> get rows => _rows;

  void addRow() {
    _rows.add(EditableTableRow());
    notifyListeners();
  }

  void removeRow(int index) {
    _rows.removeAt(index);
    notifyListeners();
  }

  void resetRows() {
    _rows = [EditableTableRow()];
    notifyListeners();
  }
}