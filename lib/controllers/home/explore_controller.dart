import 'package:get/get.dart';
import 'package:project_user/models/beauty_center_model.dart';
import 'package:project_user/models/expert_model.dart';
import 'package:project_user/models/salon_model.dart';
import 'package:project_user/services/explore_service.dart';

class ExploreController extends GetxController {
  final ExploreService _exploreService = ExploreService();

  // ===== Data =====
  var isLoading = true.obs;
  var salons = <Salon>[].obs;
  var beautyCenters = <BeautyCenter>[].obs;
  var experts = <Expert>[].obs;
  var products = <Map<String, dynamic>>[].obs;
  var categories = <Map<String, dynamic>>[].obs;

  var currentTabIndex = 0.obs;
  var selectedCity = ''.obs;
  var selectedTag = ''.obs;
  var searchQuery = ''.obs;
  var minRating = 0.0.obs;
  var genderServed = ''.obs;
  var selectedCategory = ''.obs;

  var availableCities = <String>[].obs;
  final List<String> availableTags = ['hair', 'make up', 'women', 'laser', 'skin'];

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;

    await Future.wait([
      _fetchSalons(),
      _fetchBeautyCenters(),
      _fetchExperts(),
      _fetchProducts(),
      _fetchCategories(),
    ]);

    _updateAvailableCities();
    isLoading.value = false;
  }

  Future<void> _fetchSalons() async {
    final result = await _exploreService.fetchSalons();
    if (result != null) {
      salons.value = result.map((json) => Salon.fromJson(json)).toList();
    }
  }

  Future<void> _fetchBeautyCenters() async {
    final result = await _exploreService.fetchBeautyCenters();
    if (result != null) {
      beautyCenters.value = result.map((json) => BeautyCenter.fromJson(json)).toList();
    }
  }

  Future<void> _fetchExperts() async {
    final result = await _exploreService.fetchExperts();
    if (result != null) {
      experts.value = result.map((json) => Expert.fromJson(json)).toList();
    }
  }

  Future<void> _fetchProducts() async {
    final result = await _exploreService.fetchProducts(limit: 50);
    if (result != null && result['success'] == true) {
      final data = result['data'] as Map<String, dynamic>;
      products.value = (data['items'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      products.clear();
    }
  }

  Future<void> _fetchCategories() async {
    final result = await _exploreService.fetchCategories();
    if (result != null && result['success'] == true) {
      categories.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      categories.clear();
    }
  }

  void _updateAvailableCities() {
    Set<String> cities = {};
    for (var salon in salons) {
      if (salon.city != null && salon.city!.isNotEmpty) cities.add(salon.city!);
    }
    for (var center in beautyCenters) {
      if (center.city != null && center.city!.isNotEmpty) cities.add(center.city!);
    }
    for (var expert in experts) {
      if (expert.city != null && expert.city!.isNotEmpty) cities.add(expert.city!);
    }
    availableCities.assignAll(cities.toList()..sort());
  }

  // ===== Filtered Getters =====
  List<Salon> get filteredSalons {
    return salons.where((s) {
      return (selectedCity.value.isEmpty || s.city == selectedCity.value) &&
          (selectedTag.value.isEmpty ||
              (s.description?.toLowerCase().contains(selectedTag.value.toLowerCase()) ?? false) ||
              s.name.toLowerCase().contains(selectedTag.value.toLowerCase())) &&
          (searchQuery.value.isEmpty ||
              s.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              (s.description?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false)) &&
          s.ratingAvg >= minRating.value &&
          (genderServed.value.isEmpty || s.genderServed == genderServed.value);
    }).toList();
  }

  List<BeautyCenter> get filteredBeautyCenters {
    return beautyCenters.where((c) {
      return (selectedCity.value.isEmpty || c.city == selectedCity.value) &&
          (selectedTag.value.isEmpty ||
              (c.description?.toLowerCase().contains(selectedTag.value.toLowerCase()) ?? false) ||
              (c.serviceTypes?.toLowerCase().contains(selectedTag.value.toLowerCase()) ?? false) ||
              c.name.toLowerCase().contains(selectedTag.value.toLowerCase())) &&
          (searchQuery.value.isEmpty ||
              c.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              (c.description?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false) ||
              (c.serviceTypes?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false)) &&
          c.ratingAvg >= minRating.value &&
          (genderServed.value.isEmpty || c.genderServed == genderServed.value);
    }).toList();
  }

  List<Expert> get filteredExperts {
    return experts.where((e) {
      return (selectedCity.value.isEmpty || e.city == selectedCity.value) &&
          (selectedTag.value.isEmpty ||
              (e.specialization?.toLowerCase().contains(selectedTag.value.toLowerCase()) ?? false) ||
              (e.bio?.toLowerCase().contains(selectedTag.value.toLowerCase()) ?? false) ||
              e.fullName.toLowerCase().contains(selectedTag.value.toLowerCase())) &&
          (searchQuery.value.isEmpty ||
              e.fullName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              (e.bio?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false) ||
              (e.specialization?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false)) &&
          e.ratingAvg >= minRating.value;
    }).toList();
  }

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((p) {
      bool categoryMatch = selectedCategory.value.isEmpty ||
          p['category_id']?.toString() == selectedCategory.value;
      bool searchMatch = searchQuery.value.isEmpty ||
          p['name'].toLowerCase().contains(searchQuery.value.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  List<dynamic> getCurrentItems() {
    switch (currentTabIndex.value) {
      case 0: return filteredSalons;
      case 1: return filteredBeautyCenters;
      case 2: return filteredExperts;
      case 3: return filteredProducts;
      default: return [];
    }
  }

  // ===== Actions =====
  void changeTab(int index) => currentTabIndex.value = index;
  void updateCity(String city) => selectedCity.value = city;
  void updateTag(String tag) => selectedTag.value = tag;
  void updateSearch(String query) => searchQuery.value = query;
  void updateMinRating(double val) => minRating.value = val;
  void updateGender(String gender) => genderServed.value = gender;

  void updateCategory(String categoryId) {
    if (selectedCategory.value == categoryId) {
      selectedCategory.value = '';
    } else {
      selectedCategory.value = categoryId;
    }
  }

  void clearFilters() {
    selectedCity.value = '';
    selectedTag.value = '';
    searchQuery.value = '';
    minRating.value = 0.0;
    genderServed.value = '';
    selectedCategory.value = '';
  }

  Future<void> refreshData() async {
    await fetchAllData();
  }
}