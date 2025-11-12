import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Note: You must ensure this import path remains correct in your project.
import 'package:world_cue/core/repository/gemini_service.dart';

// --- 1. NEW TOPIC MODEL ---
/// Data model for a single trending topic.
class TopicItem {
  final String topic;
  final String category;

  TopicItem({required this.topic, required this.category});

  /// Factory constructor to parse JSON map into a TopicItem instance.
  factory TopicItem.fromJson(Map<String, dynamic> json) {
    return TopicItem(
      // Use null-aware operators to provide safe fallbacks
      topic: json['topic'] as String? ?? 'Unknown Topic',
      category: json['category'] as String? ?? 'general',
    );
  }
}

// --- 2. UPDATED CONTROLLER ---

/// Controller to fetch and manage trending topics data.
class TrendingNewsController extends GetxController {
  final GeminiService service;
  TrendingNewsController({required this.service});

  // 2a. Update Rx variables to use TopicItem
  var indiaTopics = <TopicItem>[].obs;
  var globalTopics = <TopicItem>[].obs;

  var isLoading = false.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTrendingTopics();
  }

  Future<void> fetchTrendingTopics() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final data = await service.getTrendingTopics(limit: 10);

      // Ensure the lists exist and are of the correct type (List<dynamic>)
      final List<dynamic> rawIndia = data['india'] as List<dynamic>? ?? [];
      final List<dynamic> rawGlobal = data['global'] as List<dynamic>? ?? [];

      // 2b. Map the list of JSON maps to a list of TopicItem objects
      indiaTopics.assignAll(
        rawIndia.map((item) => TopicItem.fromJson(item as Map<String, dynamic>)).toList(),
      );
      globalTopics.assignAll(
        rawGlobal.map((item) => TopicItem.fromJson(item as Map<String, dynamic>)).toList(),
      );

    } catch (e) {
      debugPrint('Error fetching trending topics: $e');
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

}