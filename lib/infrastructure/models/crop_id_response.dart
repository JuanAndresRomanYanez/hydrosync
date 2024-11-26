// To parse this JSON data, do
//
//     final cropIdResponse = cropIdResponseFromJson(jsonString);

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
        input: json["input"] == null ? null : Input.fromJson(json["input"]),
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
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
    double? latitude;
    double? longitude;
    bool? similarImages;
    List<String>? images;
    DateTime? datetime;

    Input({
        this.latitude,
        this.longitude,
        this.similarImages,
        this.images,
        this.datetime,
    });

    factory Input.fromJson(Map<String, dynamic> json) => Input(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        similarImages: json["similar_images"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "similar_images": similarImages,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "datetime": datetime?.toIso8601String(),
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

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        isPlant: json["is_plant"] == null ? null : IsPlant.fromJson(json["is_plant"]),
        disease: json["disease"] == null ? null : Disease.fromJson(json["disease"]),
        crop: json["crop"] == null ? null : CropInfo.fromJson(json["crop"]),
    );

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
        suggestions: json["suggestions"] == null ? [] : List<CropSuggestion>.from(json["suggestions"]!.map((x) => CropSuggestion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "suggestions": suggestions == null ? [] : List<dynamic>.from(suggestions!.map((x) => x.toJson())),
    };
}

class CropSuggestion {
    String? id;
    String? name;
    double? probability;
    List<PurpleSimilarImage>? similarImages;
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
        similarImages: json["similar_images"] == null ? [] : List<PurpleSimilarImage>.from(json["similar_images"]!.map((x) => PurpleSimilarImage.fromJson(x))),
        details: json["details"] == null ? null : PurpleDetails.fromJson(json["details"]),
        scientificName: json["scientific_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "probability": probability,
        "similar_images": similarImages == null ? [] : List<dynamic>.from(similarImages!.map((x) => x.toJson())),
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
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        language: json["language"],
        entityId: json["entity_id"],
    );

    Map<String, dynamic> toJson() => {
        "gbif_id": gbifId,
        "image": image?.toJson(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "language": language,
        "entity_id": entityId,
    };
}

class Image {
    String? value;
    String? citation;
    String? licenseName;
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
        licenseName: json["license_name"],
        licenseUrl: json["license_url"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "citation": citation,
        "license_name": licenseName,
        "license_url": licenseUrl,
    };
}

class PurpleSimilarImage {
    String? id;
    String? url;
    double? similarity;
    String? urlSmall;
    String? licenseName;
    String? licenseUrl;
    String? citation;

    PurpleSimilarImage({
        this.id,
        this.url,
        this.similarity,
        this.urlSmall,
        this.licenseName,
        this.licenseUrl,
        this.citation,
    });

    factory PurpleSimilarImage.fromJson(Map<String, dynamic> json) => PurpleSimilarImage(
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
        suggestions: json["suggestions"] == null ? [] : List<DiseaseSuggestion>.from(json["suggestions"]!.map((x) => DiseaseSuggestion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "suggestions": suggestions == null ? [] : List<dynamic>.from(suggestions!.map((x) => x.toJson())),
    };
}

class DiseaseSuggestion {
    String? id;
    String? name;
    double? probability;
    List<FluffySimilarImage>? similarImages;
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
        similarImages: json["similar_images"] == null ? [] : List<FluffySimilarImage>.from(json["similar_images"]!.map((x) => FluffySimilarImage.fromJson(x))),
        details: json["details"] == null ? null : FluffyDetails.fromJson(json["details"]),
        scientificName: json["scientific_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "probability": probability,
        "similar_images": similarImages == null ? [] : List<dynamic>.from(similarImages!.map((x) => x.toJson())),
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
    String? leafCurling;
    String? moldDevelopment;
    String? dryingAndBrowning;
    String? loweredFoliageVigor;
    String? leafYellowingAndDropping;
    String? poorFruitingAndFlowering;
    String? whiteOrGrayPowderySpots;

    Symptoms({
        this.leafCurling,
        this.moldDevelopment,
        this.dryingAndBrowning,
        this.loweredFoliageVigor,
        this.leafYellowingAndDropping,
        this.poorFruitingAndFlowering,
        this.whiteOrGrayPowderySpots,
    });

    factory Symptoms.fromJson(Map<String, dynamic> json) => Symptoms(
        leafCurling: json["Leaf curling"],
        moldDevelopment: json["Mold development"],
        dryingAndBrowning: json["Drying and browning"],
        loweredFoliageVigor: json["Lowered foliage vigor"],
        leafYellowingAndDropping: json["Leaf yellowing and dropping"],
        poorFruitingAndFlowering: json["Poor fruiting and flowering"],
        whiteOrGrayPowderySpots: json["White or gray powdery spots"],
    );

    Map<String, dynamic> toJson() => {
        "Leaf curling": leafCurling,
        "Mold development": moldDevelopment,
        "Drying and browning": dryingAndBrowning,
        "Lowered foliage vigor": loweredFoliageVigor,
        "Leaf yellowing and dropping": leafYellowingAndDropping,
        "Poor fruiting and flowering": poorFruitingAndFlowering,
        "White or gray powdery spots": whiteOrGrayPowderySpots,
    };
}

class Taxonomy {
    String? taxonomyClass;
    String? order;
    String? family;
    String? phylum;
    String? kingdom;

    Taxonomy({
        this.taxonomyClass,
        this.order,
        this.family,
        this.phylum,
        this.kingdom,
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
    List<String>? prevention;
    List<String>? chemicalTreatment;
    List<String>? biologicalTreatment;

    Treatment({
        this.prevention,
        this.chemicalTreatment,
        this.biologicalTreatment,
    });

    factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        prevention: json["prevention"] == null ? [] : List<String>.from(json["prevention"]!.map((x) => x)),
        chemicalTreatment: json["chemical treatment"] == null ? [] : List<String>.from(json["chemical treatment"]!.map((x) => x)),
        biologicalTreatment: json["biological treatment"] == null ? [] : List<String>.from(json["biological treatment"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "prevention": prevention == null ? [] : List<dynamic>.from(prevention!.map((x) => x)),
        "chemical treatment": chemicalTreatment == null ? [] : List<dynamic>.from(chemicalTreatment!.map((x) => x)),
        "biological treatment": biologicalTreatment == null ? [] : List<dynamic>.from(biologicalTreatment!.map((x) => x)),
    };
}

class FluffySimilarImage {
    String? id;
    String? url;
    double? similarity;
    String? urlSmall;

    FluffySimilarImage({
        this.id,
        this.url,
        this.similarity,
        this.urlSmall,
    });

    factory FluffySimilarImage.fromJson(Map<String, dynamic> json) => FluffySimilarImage(
        id: json["id"],
        url: json["url"],
        similarity: json["similarity"]?.toDouble(),
        urlSmall: json["url_small"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "similarity": similarity,
        "url_small": urlSmall,
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
