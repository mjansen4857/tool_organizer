import 'package:tool_organizer/objects/tool.dart';

class LendableTool extends Tool {
  String lentTo;
  DateTime requiredReturnDate;

  LendableTool(
      String toolName,
      String barcode,
      String owner,
      DateTime purchaseDate,
      List<String> categories,
      this.lentTo,
      this.requiredReturnDate)
      : super(toolName, barcode, owner, purchaseDate, categories);
}
