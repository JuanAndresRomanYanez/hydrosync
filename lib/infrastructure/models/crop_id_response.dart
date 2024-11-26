// To parse this JSON data, do
//
//     final cropIdResponse = cropIdResponseFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

CropIdResponse cropIdResponseFromJson(String str) => CropIdResponse.fromJson(json.decode(str));

String cropIdResponseToJson(CropIdResponse data) => json.encode(data.toJson());

class CropIdResponse {
    String? accessToken;
    String? modelVersion;
    dynamic customId;
    Input? input;
    Result? result;
    String? status;
    bool? slaCompliantClient;
    bool? slaCompliantSystem;
    double? created;
    double? completed;

    CropIdResponse({
      this.accessToken,
      this.modelVersion,
      this.customId,
      this.input,
      this.result,
      this.status,
      this.slaCompliantClient,
      this.slaCompliantSystem,
      this.created,
      this.completed,
    });

    factory CropIdResponse.fromJson(Map<String, dynamic> json) => CropIdResponse(
      accessToken: json["access_token"],
      modelVersion: json["model_version"],
      customId: json["custom_id"],
      input: json["input"] != null ? Input.fromJson(json["input"]) : null,
      result: json["result"] != null ? Result.fromJson(json["result"]) : null,
      status: json["status"],
      slaCompliantClient: json["sla_compliant_client"],
      slaCompliantSystem: json["sla_compliant_system"],
      created: json["created"]?.toDouble(),
      completed: json["completed"]?.toDouble(),
    );


    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "model_version": modelVersion,
        "custom_id": customId,
        "input": input?.toJson(),
        "result": result?.toJson(),
        "status": status,
        "sla_compliant_client": slaCompliantClient,
        "sla_compliant_system": slaCompliantSystem,
        "created": created,
        "completed": completed,
    };
}

class Input {
    double latitude;
    double longitude;
    bool similarImages;
    List<String> images;
    DateTime datetime;

    Input({
        required this.latitude,
        required this.longitude,
        required this.similarImages,
        required this.images,
        required this.datetime,
    });

    factory Input.fromJson(Map<String, dynamic> json) => Input(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        similarImages: json["similar_images"],
        images: List<String>.from(json["images"].map((x) => x)),
        datetime: DateTime.parse(json["datetime"]),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "similar_images": similarImages,
        "images": List<dynamic>.from(images.map((x) => x)),
        "datetime": datetime.toIso8601String(),
    };
}

class Result {
    IsPlant? isPlant;
    Disease? disease;
    CropInfo? crop;

    Result({
      this.isPlant,
      this.disease,
      this.crop,
    });

    factory Result.fromJson(Map<String, dynamic> json) {
      IsPlant? isPlant;
      Disease? disease;
      CropInfo? crop;

      try {
        if (json["is_plant"] != null) {
          isPlant = IsPlant.fromJson(json["is_plant"]);
        }
      } catch (e) {
        print('Error al parsear isPlant: $e');
      }

      try {
        if (json["disease"] != null) {
          disease = Disease.fromJson(json["disease"]);
        }
      } catch (e) {
        print('Error al parsear disease: $e');
      }

      try {
        if (json["crop"] != null) {
          crop = CropInfo.fromJson(json["crop"]);
        }
      } catch (e) {
        print('Contenido de json["crop"]: ${jsonEncode(json["crop"])}');
        print('Error al parsear crop: $e');
      }

      return Result(
        isPlant: isPlant,
        disease: disease,
        crop: crop,
      );
    }

    // factory Result.fromJson(Map<String, dynamic> json) => Result(
    //   isPlant: json["is_plant"] != null ? IsPlant.fromJson(json["is_plant"]) : null,
    //   disease: json["disease"] != null ? Disease.fromJson(json["disease"]) : null,
    //   crop: json["crop"] != null ? CropInfo.fromJson(json["crop"]) : null,
    // );

    Map<String, dynamic> toJson() => {
        "is_plant": isPlant?.toJson(),
        "disease": disease?.toJson(),
        "crop": crop?.toJson(),
    };
}

class CropInfo {
    List<CropSuggestion>? suggestions;

    CropInfo({
        this.suggestions,
    });

    factory CropInfo.fromJson(Map<String, dynamic> json) => CropInfo(
      suggestions: json["suggestions"] != null
        ? List<CropSuggestion>.from(json["suggestions"].map((x) => CropSuggestion.fromJson(x)))
        : [],
    );

    Map<String, dynamic> toJson() => {
      "suggestions": List<dynamic>.from(suggestions!.map((x) => x.toJson())),
    };
}

class CropSuggestion {
    String? id;
    String? name;
    double? probability;
    List<SimilarImage>? similarImages;
    PurpleDetails? details;
    String? scientificName;

    CropSuggestion({
        this.id,
        this.name,
        this.probability,
        this.similarImages,
        this.details,
        this.scientificName,
    });

    factory CropSuggestion.fromJson(Map<String, dynamic> json) => CropSuggestion(
      id: json["id"],
      name: json["name"],
      probability: json["probability"]?.toDouble(),
      similarImages: json["similar_images"] != null
        ? List<SimilarImage>.from(json["similar_images"].map((x) => SimilarImage.fromJson(x)))
        : [],
      details: json["details"] != null ? PurpleDetails.fromJson(json["details"]) : null,
      scientificName: json["scientific_name"],
    );


    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "probability": probability,
        "similar_images": List<dynamic>.from(similarImages!.map((x) => x.toJson())),
        "details": details?.toJson(),
        "scientific_name": scientificName,
    };
}

class PurpleDetails {
    int? gbifId;
    Image? image;
    List<Image>? images;
    String? language;
    String? entityId;

    PurpleDetails({
      this.gbifId,
      this.image,
      this.images,
      this.language,
      this.entityId,
    });

    factory PurpleDetails.fromJson(Map<String, dynamic> json) => PurpleDetails(
      gbifId: json["gbif_id"],
      image: json["image"] != null ? Image.fromJson(json["image"]) : null,
      images: json["images"] != null
        ? List<Image>.from(json["images"].map((x) => Image.fromJson(x)))
        : [],
      language: json["language"],
      entityId: json["entity_id"],
    );

    Map<String, dynamic> toJson() => {
        "gbif_id": gbifId,
        "image": image?.toJson(),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "language": language,
        "entity_id": entityId,
    };
}

class Image {
    String? value;
    String? citation;
    LicenseName? licenseName;
    String? licenseUrl;

    Image({
      this.value,
      this.citation,
      this.licenseName,
      this.licenseUrl,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
      value: json["value"],
      citation: json["citation"],
      licenseName: json["license_name"] != null
        ? licenseNameValues.map[json["license_name"]]
        : null,
      licenseUrl: json["license_url"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "citation": citation,
        "license_name": licenseNameValues.reverse[licenseName],
        "license_url": licenseUrl,
    };
}

enum LicenseName {
    CC0,
    CC_BY_25,
    CC_BY_30,
    CC_BY_SA_30
}

final licenseNameValues = EnumValues({
    "CC0": LicenseName.CC0,
    "CC BY 2.5": LicenseName.CC_BY_25,
    "CC BY 3.0": LicenseName.CC_BY_30,
    "CC BY-SA 3.0": LicenseName.CC_BY_SA_30
});

class SimilarImage {
    String id;
    String url;
    double similarity;
    String urlSmall;
    String? licenseName;
    String? licenseUrl;
    String? citation;

    SimilarImage({
        required this.id,
        required this.url,
        required this.similarity,
        required this.urlSmall,
        this.licenseName,
        this.licenseUrl,
        this.citation,
    });

    factory SimilarImage.fromJson(Map<String, dynamic> json) => SimilarImage(
        id: json["id"],
        url: json["url"],
        similarity: json["similarity"]?.toDouble(),
        urlSmall: json["url_small"],
        licenseName: json["license_name"],
        licenseUrl: json["license_url"],
        citation: json["citation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "similarity": similarity,
        "url_small": urlSmall,
        "license_name": licenseName,
        "license_url": licenseUrl,
        "citation": citation,
    };
}

class Disease {
    List<DiseaseSuggestion>? suggestions;

    Disease({
      this.suggestions,
    });

    factory Disease.fromJson(Map<String, dynamic> json) => Disease(
      suggestions: json["suggestions"] != null
        ? List<DiseaseSuggestion>.from(json["suggestions"].map((x) => DiseaseSuggestion.fromJson(x)))
        : [],
    );

    Map<String, dynamic> toJson() => {
        "suggestions": suggestions != null ? List<dynamic>.from(suggestions!.map((x) => x.toJson())) : [],
    };

}

class DiseaseSuggestion {
    String? id;
    String? name;
    double? probability;
    List<SimilarImage>? similarImages;
    FluffyDetails? details;
    String? scientificName;

    DiseaseSuggestion({
        this.id,
        this.name,
        this.probability,
        this.similarImages,
        this.details,
        this.scientificName,
    });

    factory DiseaseSuggestion.fromJson(Map<String, dynamic> json) => DiseaseSuggestion(
      id: json["id"],
      name: json["name"],
      probability: json["probability"]?.toDouble(),
      similarImages: json["similar_images"] != null
        ? List<SimilarImage>.from(json["similar_images"].map((x) => SimilarImage.fromJson(x)))
        : [],
      details: json["details"] != null ? FluffyDetails.fromJson(json["details"]) : null,
      scientificName: json["scientific_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "probability": probability,
        "similar_images": List<dynamic>.from(similarImages!.map((x) => x.toJson())),
        "details": details?.toJson(),
        "scientific_name": scientificName,
    };
}

class FluffyDetails {
    List<String>? commonNames;
    String? type;
    Taxonomy? taxonomy;
    int? gbifId;
    String? eppoCode;
    dynamic eppoRegulationStatus;
    String? wikiUrl;
    Image? wikiDescription;
    Image? image;
    List<Image>? images;
    String? description;
    Symptoms? symptoms;
    String? severity;
    String? spreading;
    Treatment? treatment;
    String? language;
    String? entityId;

    FluffyDetails({
        this.commonNames,
        this.type,
        this.taxonomy,
        this.gbifId,
        this.eppoCode,
        this.eppoRegulationStatus,
        this.wikiUrl,
        this.wikiDescription,
        this.image,
        this.images,
        this.description,
        this.symptoms,
        this.severity,
        this.spreading,
        this.treatment,
        this.language,
        this.entityId,
    });

    factory FluffyDetails.fromJson(Map<String, dynamic> json) => FluffyDetails(
      commonNames: json["common_names"] == null ? null : List<String>.from(json["common_names"]),
      type: json["type"],
      taxonomy: json["taxonomy"] == null ? null : Taxonomy.fromJson(json["taxonomy"]),
      gbifId: json["gbif_id"],
      eppoCode: json["eppo_code"],
      eppoRegulationStatus: json["eppo_regulation_status"],
      wikiUrl: json["wiki_url"],
      wikiDescription: json["wiki_description"] == null ? null : Image.fromJson(json["wiki_description"]),
      image: json["image"] == null ? null : Image.fromJson(json["image"]),
      images: json["images"] == null ? null : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      description: json["description"],
      symptoms: json["symptoms"] == null ? null : Symptoms.fromJson(json["symptoms"]),
      severity: json["severity"],
      spreading: json["spreading"],
      treatment: json["treatment"] == null ? null : Treatment.fromJson(json["treatment"]),
      language: json["language"],
      entityId: json["entity_id"],
    );

    Map<String, dynamic> toJson() => {
        "common_names": commonNames == null ? [] : List<dynamic>.from(commonNames!.map((x) => x)),
        "type": type,
        "taxonomy": taxonomy?.toJson(),
        "gbif_id": gbifId,
        "eppo_code": eppoCode,
        "eppo_regulation_status": eppoRegulationStatus,
        "wiki_url": wikiUrl,
        "wiki_description": wikiDescription?.toJson(),
        "image": image?.toJson(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "description": description,
        "symptoms": symptoms?.toJson(),
        "severity": severity,
        "spreading": spreading,
        "treatment": treatment?.toJson(),
        "language": language,
        "entity_id": entityId,
    };
}

class Symptoms {
    String? leafDrop;
    String? whiteStreaks;
    String? stuntedGrowth;
    String? poorCropYield;
    String? plantDiscoloration;
    String? blackSpotsOnLeaves;
    String? malformedFruitsAndFlowers;
    String? sootyMold;
    String? fruitDamage;
    String? leafCurling;
    String? leafWilting;
    String? flowerDamage;
    String? plantNecrosis;
    String? stickySubstancePresence;
    String? discolorationOfPlantParts;
    String? leafDiscoloration;
    String? diebackOfBranches;
    String? prematureLeafDrop;
    String? stuntedPlantGrowth;
    String? visibleScaleCovers;
    String? formationOfSootyMold;
    String? damageToFruitsAndFlowers;
    String? declineInOverallPlantHealth;

    Symptoms({
        this.leafDrop,
        this.whiteStreaks,
        this.stuntedGrowth,
        this.poorCropYield,
        this.plantDiscoloration,
        this.blackSpotsOnLeaves,
        this.malformedFruitsAndFlowers,
        this.sootyMold,
        this.fruitDamage,
        this.leafCurling,
        this.leafWilting,
        this.flowerDamage,
        this.plantNecrosis,
        this.stickySubstancePresence,
        this.discolorationOfPlantParts,
        this.leafDiscoloration,
        this.diebackOfBranches,
        this.prematureLeafDrop,
        this.stuntedPlantGrowth,
        this.visibleScaleCovers,
        this.formationOfSootyMold,
        this.damageToFruitsAndFlowers,
        this.declineInOverallPlantHealth,
    });

    factory Symptoms.fromJson(Map<String, dynamic> json) => Symptoms(
        leafDrop: json["Leaf drop"],
        whiteStreaks: json["White streaks"],
        stuntedGrowth: json["Stunted growth"],
        poorCropYield: json["Poor crop yield"],
        plantDiscoloration: json["Plant discoloration"],
        blackSpotsOnLeaves: json["Black spots on leaves"],
        malformedFruitsAndFlowers: json["Malformed fruits and flowers"],
        sootyMold: json["Sooty Mold"],
        fruitDamage: json["Fruit damage"],
        leafCurling: json["Leaf curling"],
        leafWilting: json["Leaf wilting"],
        flowerDamage: json["Flower damage"],
        plantNecrosis: json["Plant necrosis"],
        stickySubstancePresence: json["Sticky substance presence"],
        discolorationOfPlantParts: json["Discoloration of plant parts"],
        leafDiscoloration: json["Leaf discoloration"],
        diebackOfBranches: json["Dieback of branches"],
        prematureLeafDrop: json["Premature leaf drop"],
        stuntedPlantGrowth: json["Stunted plant growth"],
        visibleScaleCovers: json["Visible scale covers"],
        formationOfSootyMold: json["Formation of sooty mold"],
        damageToFruitsAndFlowers: json["Damage to fruits and flowers"],
        declineInOverallPlantHealth: json["Decline in overall plant health"],
    );

    Map<String, dynamic> toJson() => {
        "Leaf drop": leafDrop,
        "White streaks": whiteStreaks,
        "Stunted growth": stuntedGrowth,
        "Poor crop yield": poorCropYield,
        "Plant discoloration": plantDiscoloration,
        "Black spots on leaves": blackSpotsOnLeaves,
        "Malformed fruits and flowers": malformedFruitsAndFlowers,
        "Sooty Mold": sootyMold,
        "Fruit damage": fruitDamage,
        "Leaf curling": leafCurling,
        "Leaf wilting": leafWilting,
        "Flower damage": flowerDamage,
        "Plant necrosis": plantNecrosis,
        "Sticky substance presence": stickySubstancePresence,
        "Discoloration of plant parts": discolorationOfPlantParts,
        "Leaf discoloration": leafDiscoloration,
        "Dieback of branches": diebackOfBranches,
        "Premature leaf drop": prematureLeafDrop,
        "Stunted plant growth": stuntedPlantGrowth,
        "Visible scale covers": visibleScaleCovers,
        "Formation of sooty mold": formationOfSootyMold,
        "Damage to fruits and flowers": damageToFruitsAndFlowers,
        "Decline in overall plant health": declineInOverallPlantHealth,
    };
}

class Taxonomy {
    String taxonomyClass;
    String order;
    String family;
    String phylum;
    String kingdom;

    Taxonomy({
        required this.taxonomyClass,
        required this.order,
        required this.family,
        required this.phylum,
        required this.kingdom,
    });

    factory Taxonomy.fromJson(Map<String, dynamic> json) => Taxonomy(
        taxonomyClass: json["class"],
        order: json["order"],
        family: json["family"],
        phylum: json["phylum"],
        kingdom: json["kingdom"],
    );

    Map<String, dynamic> toJson() => {
        "class": taxonomyClass,
        "order": order,
        "family": family,
        "phylum": phylum,
        "kingdom": kingdom,
    };
}

class Treatment {
    List<String> prevention;
    List<String> chemicalTreatment;
    List<String> biologicalTreatment;

    Treatment({
        required this.prevention,
        required this.chemicalTreatment,
        required this.biologicalTreatment,
    });

    factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        prevention: List<String>.from(json["prevention"].map((x) => x)),
        chemicalTreatment: List<String>.from(json["chemical treatment"].map((x) => x)),
        biologicalTreatment: List<String>.from(json["biological treatment"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "prevention": List<dynamic>.from(prevention.map((x) => x)),
        "chemical treatment": List<dynamic>.from(chemicalTreatment.map((x) => x)),
        "biological treatment": List<dynamic>.from(biologicalTreatment.map((x) => x)),
    };
}

class IsPlant {
    double? probability;
    double? threshold;
    bool? binary;

    IsPlant({
      this.probability,
      this.threshold,
      this.binary,
    });

    factory IsPlant.fromJson(Map<String, dynamic> json) => IsPlant(
        probability: json["probability"]?.toDouble(),
        threshold: json["threshold"]?.toDouble(),
        binary: json["binary"],
    );

    Map<String, dynamic> toJson() => {
        "probability": probability,
        "threshold": threshold,
        "binary": binary,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
