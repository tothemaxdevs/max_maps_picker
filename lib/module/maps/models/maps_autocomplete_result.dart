class MapsAutocompleteResult {
  bool? success;
  String? message;
  PredictionData? data;

  MapsAutocompleteResult({
    this.success,
    this.message,
    this.data,
  });

  factory MapsAutocompleteResult.fromJson(Map<String, dynamic> json) {
    return MapsAutocompleteResult(
      success: json['success'],
      message: json['message'],
      data: PredictionData.fromJson(json['data']),
    );
  }
}

class PredictionData {
  List<Prediction>? predictions;

  PredictionData({
    this.predictions,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    var predictionList = json['predictions'] as List;
    List<Prediction> predictions =
        predictionList.map((e) => Prediction.fromJson(e)).toList();
    return PredictionData(predictions: predictions);
  }
}

class Prediction {
  String? mainText;
  String? secondaryText;
  String? placeId;

  Prediction({
    this.mainText,
    this.secondaryText,
    this.placeId,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      mainText: json['main_text'],
      secondaryText: json['secondary_text'],
      placeId: json['place_id'],
    );
  }
}
