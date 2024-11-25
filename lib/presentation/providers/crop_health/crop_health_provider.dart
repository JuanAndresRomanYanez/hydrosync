import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hydrosync/domain/entities/entities.dart';
import 'package:hydrosync/domain/repositories/crop_health_repository.dart';

import 'package:hydrosync/presentation/providers/providers.dart';

class CropHealthState {
  final File? selectedImage;
  final CropHealth? analysisResult;
  final bool isLoading;
  final String? errorMessage;

  CropHealthState({
    this.selectedImage,
    this.analysisResult,
    this.isLoading = false,
    this.errorMessage,
  });

  CropHealthState copyWith({
    File? selectedImage,
    CropHealth? analysisResult,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CropHealthState(
      selectedImage: selectedImage ?? this.selectedImage,
      analysisResult: analysisResult ?? this.analysisResult,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class CropHealthNotifier extends StateNotifier<CropHealthState> {
  final CropHealthRepository repository;

  CropHealthNotifier(this.repository) : super(CropHealthState());

  Future<void> selectImage(File image) async {
    state = state.copyWith(selectedImage: image, analysisResult: null, errorMessage: null);
  }

  Future<void> analyzeImage() async {
    if (state.selectedImage == null) {
      state = state.copyWith(errorMessage: 'Por favor, selecciona una imagen.');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final result = await repository.analyzeImage(state.selectedImage!.path);
      state = state.copyWith(analysisResult: result, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error al analizar la imagen: $e',
      );
    }
  }
}

final cropHealthProvider = StateNotifierProvider<CropHealthNotifier, CropHealthState>((ref) {
  final repository = ref.watch(cropHealthRepositoryProvider);
  return CropHealthNotifier(repository);
});
