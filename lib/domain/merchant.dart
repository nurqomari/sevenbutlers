class Merchant {
  bool available_for_order;
  String name;
  List<dynamic> cuisines;
  String category;
  String image_url;
  String detail_image_url;
  String scene_image_url;
  String scene_detail_image_url;
  String open_at;
  String close_at;
  int time_zone;
  double rating;
  String address;
  String building_name;
  String building_floor;
  String building_room_number;
  String zipcode;
  String city;
  String state_province;
  String country;
  double distance;
  int delivery_time;
  bool is_favorite;
  double latitude;
  double longitude;
  int preparation_time;
  double average_price;
  int price_rating;
  bool has_product_discount;
  bool is_open;
  bool is_coming_soon;
  bool available_for_pickup;
  bool available_for_delivery;
  bool pickup_temporary_unavailable;
  bool delivery_temporary_unavailable;
  int id;

  Merchant([
    this.available_for_order,
    this.name,
    this.cuisines,
    this.category,
    this.image_url,
    this.detail_image_url,
    this.scene_image_url,
    this.scene_detail_image_url,
    this.open_at,
    this.close_at,
    this.time_zone,
    this.rating,
    this.address,
    this.building_name,
    this.building_floor,
    this.building_room_number,
    this.zipcode,
    this.city,
    this.state_province,
    this.country,
    this.distance,
    this.delivery_time,
    this.is_favorite,
    this.latitude,
    this.longitude,
    this.preparation_time,
    this.average_price,
    this.price_rating,
    this.has_product_discount,
    this.is_open,
    this.is_coming_soon,
    this.available_for_pickup,
    this.available_for_delivery,
    this.pickup_temporary_unavailable,
    this.delivery_temporary_unavailable,
    this.id,
  ]);

  Merchant.parse(responseData) {
    try {
      available_for_order = responseData['available_for_order'];
      name = responseData['name'];
      cuisines = responseData['cuisines'];
      category = responseData['category'];
      image_url = responseData['image_url'];
      detail_image_url = responseData['detail_image_url'];
      scene_image_url = responseData['scene_image_url'];
      scene_detail_image_url = responseData['scene_detail_image_url'];
      open_at = responseData['open_at'];
      close_at = responseData['close_at'];
      time_zone = responseData['time_zone'];
      rating = responseData['rating'];
      address = responseData['address'];
      building_name = responseData['building_name'];
      building_floor = responseData['building_floor'];
      building_room_number = responseData['building_room_number'];
      zipcode = responseData['zipcode'];
      city = responseData['city'];
      state_province = responseData['state_province'];
      country = responseData['country'];
      distance = responseData['distance'];
      delivery_time = responseData['delivery_time'];
      is_favorite = responseData['is_favorite'];
      latitude = responseData['latitude'];
      longitude = responseData['longitude'];
      preparation_time = responseData['preparation_time'];
      average_price = responseData['average_price'];
      price_rating = responseData['price_rating'];
      has_product_discount = responseData['has_product_discount'];
      is_open = responseData['is_open'];
      is_coming_soon = responseData['is_coming_soon'];
      available_for_pickup = responseData['available_for_pickup'];
      available_for_delivery = responseData['available_for_delivery'];
      pickup_temporary_unavailable =
          responseData['pickup_temporary_unavailable'];
      delivery_temporary_unavailable =
          responseData['delivery_temporary_unavailable'];
      id = responseData['id'];
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      // 'delivery_fee': deliveryFee,
      'distance': distance,
    };
  }
}
