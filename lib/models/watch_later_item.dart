class WatchLaterItem {
  final String id;
  final String title;
  final int quantity;
  final String imageUrl;

  WatchLaterItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.imageUrl,
  });

  WatchLaterItem copyWith({
    String? id,
    String? title,
    int? quantity,
    String? imageUrl,
  }) {
    return WatchLaterItem(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
