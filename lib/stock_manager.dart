class StockManager {
  static List<String> savedStocks = [];

  static void addStock(String stock) {
    if (!savedStocks.contains(stock)) {
      savedStocks.add(stock);
    }
  }

  static void removeStock(String stock) {
    savedStocks.remove(stock);
  }
}
