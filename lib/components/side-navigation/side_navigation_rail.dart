import 'package:flutter/material.dart';

class SideNavigationRail extends StatefulWidget {
  SideNavigationRail(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});

  int selectedIndex = 0;
  void Function(int) onDestinationSelected;

  @override
  State<SideNavigationRail> createState() => _SideNavigationRailState();
}

class _SideNavigationRailState extends State<SideNavigationRail> {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      minWidth: 100,
      destinations: [
        NavigationRailDestination(
            icon: Icon(Icons.collections_bookmark_outlined,
                color: Theme.of(context).primaryColor),
            label: const Text("Collections")),
        NavigationRailDestination(
            icon: Icon(
              Icons.http,
              color: Theme.of(context).primaryColor,
            ),
            label: const Text("REST")),
        NavigationRailDestination(
            icon: Icon(
              Icons.network_check,
              color: Theme.of(context).primaryColor,
            ),
            label: const Text("TCP")),
        NavigationRailDestination(
            icon: Icon(
              Icons.network_cell,
              color: Theme.of(context).primaryColor,
            ),
            label: const Text("UDP")),
        NavigationRailDestination(
            icon: Icon(
              Icons.network_ping_rounded,
              color: Theme.of(context).primaryColor,
            ),
            label: const Text("Websockets")),
        NavigationRailDestination(
            icon: Icon(
              Icons.code,
              color: Theme.of(context).primaryColor,
            ),
            label: const Text("Mock Backend")),
        NavigationRailDestination(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
            label: const Text("Settings")),
      ],
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          widget.selectedIndex = index;
          widget.onDestinationSelected(index);
        });
      },
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle: TextStyle(
          color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
      unselectedLabelTextStyle:
          const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
      useIndicator: true,
      indicatorColor: Theme.of(context).primaryColor.withOpacity(0.5),
      selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
    );
  }
}
