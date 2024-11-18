import 'package:flutter/material.dart';

import '../../dto/request_dto.dart';
import '../../utils/colors/color_service.dart';

class CollectionSelectionFile extends StatelessWidget {
  CollectionSelectionFile({super.key, required this.request});

  RequestDto request;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      hoverColor: Colors.brown,
      leading: Text(
        request.method,
        style: TextStyle(color: ColorService.colorsMap[request.method]),
      ),
      title: Text(request.name),
    );
  }
}
