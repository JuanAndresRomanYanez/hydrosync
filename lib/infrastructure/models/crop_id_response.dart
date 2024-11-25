// To parse this JSON data, do
//
//     final cropIdResponse = cropIdResponseFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

CropIdResponse cropIdResponseFromJson(String str) => CropIdResponse.fromJson(json.decode(str));

String cropIdResponseToJson(CropIdResponse data) => json.encode(data.toJson());

class CropIdResponse {
    String accessToken;
    String modelVersion;
    dynamic customId;
    Input input;
    Result result;
    String status;
    bool slaCompliantClient;
    bool slaCompliantSystem;
    double created;
    double completed;

    CropIdResponse({
        required this.accessToken,
        required this.modelVersion,
        required this.customId,
        required this.input,
        required this.result,
        required this.status,
        required this.slaCompliantClient,
        required this.slaCompliantSystem,
        required this.created,
        required this.completed,
    });

    factory CropIdResponse.fromJson(Map<String, dynamic> json) => CropIdResponse(
        accessToken: json["access_token"],
        modelVersion: json["model_version"],
        customId: json["custom_id"],
        input: Input.fromJson(json["input"]),
        result: Result.fromJson(json["result"]),
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
        "input": input.toJson(),
        "result": result.toJson(),
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
    IsPlant isPlant;
    Disease disease;
    CropInfo crop;

    Result({
        required this.isPlant,
        required this.disease,
        required this.crop,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        isPlant: IsPlant.fromJson(json["is_plant"]),
        disease: Disease.fromJson(json["disease"]),
        crop: CropInfo.fromJson(json["crop"]),
    );

    Map<String, dynamic> toJson() => {
        "is_plant": isPlant.toJson(),
        "disease": disease.toJson(),
        "crop": crop.toJson(),
    };
}

class CropInfo {
    List<CropSuggestion> suggestions;

    CropInfo({
        required this.suggestions,
    });

    factory CropInfo.fromJson(Map<String, dynamic> json) => CropInfo(
        suggestions: List<CropSuggestion>.from(json["suggestions"].map((x) => CropSuggestion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "suggestions": List<dynamic>.from(suggestions.map((x) => x.toJson())),
    };
}

class CropSuggestion {
    String id;
    String name;
    double probability;
    List<SimilarImage> similarImages;
    PurpleDetails details;
    String scientificName;

    CropSuggestion({
        required this.id,
        required this.name,
        required this.probability,
        required this.similarImages,
        required this.details,
        required this.scientificName,
    });

    factory CropSuggestion.fromJson(Map<String, dynamic> json) => CropSuggestion(
        id: json["id"],
        name: json["name"],
        probability: json["probability"]?.toDouble(),
        similarImages: List<SimilarImage>.from(json["similar_images"].map((x) => SimilarImage.fromJson(x))),
        details: PurpleDetails.fromJson(json["details"]),
        scientificName: json["scientific_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "probability": probability,
        "similar_images": List<dynamic>.from(similarImages.map((x) => x.toJson())),
        "details": details.toJson(),
        "scientific_name": scientificName,
    };
}

class PurpleDetails {
    int gbifId;
    Image image;
    List<Image> images;
    String language;
    String entityId;

    PurpleDetails({
        required this.gbifId,
        required this.image,
        required this.images,
        required this.language,
        required this.entityId,
    });

    factory PurpleDetails.fromJson(Map<String, dynamic> json) => PurpleDetails(
        gbifId: json["gbif_id"],
        image: Image.fromJson(json["image"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        language: json["language"],
        entityId: json["entity_id"],
    );

    Map<String, dynamic> toJson() => {
        "gbif_id": gbifId,
        "image": image.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "language": language,
        "entity_id": entityId,
    };
}

class Image {
    String value;
    String? citation;
    LicenseName licenseName;
    String licenseUrl;

    Image({
        required this.value,
        required this.citation,
        required this.licenseName,
        required this.licenseUrl,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        value: json["value"],
        citation: json["citation"],
        licenseName: licenseNameValues.map[json["license_name"]]!,
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
    List<DiseaseSuggestion> suggestions;

    Disease({
        required this.suggestions,
    });

    factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        suggestions: List<DiseaseSuggestion>.from(json["suggestions"].map((x) => DiseaseSuggestion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "suggestions": List<dynamic>.from(suggestions.map((x) => x.toJson())),
    };
}

class DiseaseSuggestion {
    String id;
    String name;
    double probability;
    List<SimilarImage> similarImages;
    FluffyDetails details;
    String scientificName;

    DiseaseSuggestion({
        required this.id,
        required this.name,
        required this.probability,
        required this.similarImages,
        required this.details,
        required this.scientificName,
    });

    factory DiseaseSuggestion.fromJson(Map<String, dynamic> json) => DiseaseSuggestion(
        id: json["id"],
        name: json["name"],
        probability: json["probability"]?.toDouble(),
        similarImages: List<SimilarImage>.from(json["similar_images"].map((x) => SimilarImage.fromJson(x))),
        details: FluffyDetails.fromJson(json["details"]),
        scientificName: json["scientific_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "probability": probability,
        "similar_images": List<dynamic>.from(similarImages.map((x) => x.toJson())),
        "details": details.toJson(),
        "scientific_name": scientificName,
    };
}

class FluffyDetails {
    List<String>? commonNames;
    String type;
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
    String language;
    String entityId;

    FluffyDetails({
        required this.commonNames,
        required this.type,
        required this.taxonomy,
        required this.gbifId,
        required this.eppoCode,
        required this.eppoRegulationStatus,
        required this.wikiUrl,
        required this.wikiDescription,
        required this.image,
        required this.images,
        required this.description,
        required this.symptoms,
        required this.severity,
        required this.spreading,
        required this.treatment,
        required this.language,
        required this.entityId,
    });

    factory FluffyDetails.fromJson(Map<String, dynamic> json) => FluffyDetails(
        commonNames: json["common_names"] == null ? [] : List<String>.from(json["common_names"]!.map((x) => x)),
        type: json["type"],
        taxonomy: json["taxonomy"] == null ? null : Taxonomy.fromJson(json["taxonomy"]),
        gbifId: json["gbif_id"],
        eppoCode: json["eppo_code"],
        eppoRegulationStatus: json["eppo_regulation_status"],
        wikiUrl: json["wiki_url"],
        wikiDescription: json["wiki_description"] == null ? null : Image.fromJson(json["wiki_description"]),
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
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
    double probability;
    double threshold;
    bool binary;

    IsPlant({
        required this.probability,
        required this.threshold,
        required this.binary,
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
