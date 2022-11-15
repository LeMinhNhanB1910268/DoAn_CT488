class WatchLaterItem {
  final String id;
  final String title;
  final String imageUrl;
  final double volumnCount;

  WatchLaterItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.volumnCount,
  });

  WatchLaterItem copyWith({
    String? id,
    String? title,
    String? imageUrl,
    double? volumnCount,
  }) {
    return WatchLaterItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      volumnCount: volumnCount ?? this.volumnCount,
    );
  }
}
