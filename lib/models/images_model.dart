class Backdrop {
    double aspectRatio;
    int height;
    String filePath;
    int width;

    Backdrop({
        required this.aspectRatio,
        required this.height,
        required this.filePath,
        required this.width,
    });


    factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
        aspectRatio: json["aspect_ratio"].toDouble(),
        height: json["height"],
        filePath: json["file_path"],
        width: json["width"],
    );



    String fullImageUrl() {
        if (filePath.isNotEmpty) {
            return 'https://image.tmdb.org/t/p/w500$filePath';
        } else {
            return '';
        }
    }

}
