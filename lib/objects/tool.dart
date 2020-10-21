class Tool {
  final String toolName;
  final String barcode;
  final String owner;
  final DateTime purchaseDate;
  final List<String> categories;

  Tool(this.toolName, this.barcode, this.owner, this.purchaseDate,
      this.categories);
}
