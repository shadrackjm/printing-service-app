class ServiceProvided {
  final String serviceName;
  final String serviceDescription;
  final int price;
  final int id;

  const ServiceProvided({
    this.serviceName = '',
    this.serviceDescription = '',
    this.price = 0,
    this.id = 0,
  });

  // map json to post model
  factory ServiceProvided.fromJson(Map<String, dynamic> json) {
    return ServiceProvided(
      serviceName: json['serviceName'],
      serviceDescription: json['serviceDescription'],
      price: json['price'],
      id: json['id'],
    );
  }
}
