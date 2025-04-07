import 'package:flutter/material.dart';


///classes to provide page and tableRows indexes
class PageIndexInherited extends InheritedWidget {
  final int currentPageIndex;
  

  const PageIndexInherited({
    super.key,
    required this.currentPageIndex,
    required super.child,
  });

  @override
  bool updateShouldNotify(PageIndexInherited oldWidget) {
    return currentPageIndex != oldWidget.currentPageIndex;
  }

  static PageIndexInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PageIndexInherited>();
  }
}

class TableIndexInherited extends InheritedWidget {
final int currentTableIndex;
  

  const TableIndexInherited({
    super.key,
    required this.currentTableIndex,
    required super.child,
  });

   @override
  bool updateShouldNotify(TableIndexInherited oldWidget) {
    return currentTableIndex != oldWidget.currentTableIndex;
  }

  static TableIndexInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TableIndexInherited>();
  }
}