import 'package:flutter/material.dart';
import 'package:project/services/service_model.dart';

class ServiceProviderProvider extends ChangeNotifier {
  Service? _selectedService;
  List<Service> _services = [
    Service(assetImage: 'lib/assets/icons/electrician2.png', title: 'Electricians'),
    Service(assetImage: 'lib/assets/icons/plumber.png', title: 'Plumbers'),
    Service(assetImage: 'lib/assets/icons/painter.png', title: 'Painters'),
    Service(assetImage: 'lib/assets/icons/mechanic.png', title: 'Car Mechanics'),
    Service(assetImage: 'lib/assets/icons/maid.png', title: 'House helps'),
    Service(assetImage: 'lib/assets/icons/gardener.png', title: 'Gardeners'),
  ];

  Service? get selectedService => _selectedService;
  List<Service> get services => _services;

  void selectService(Service service) {
    _selectedService = service;
    notifyListeners();
  }
}
