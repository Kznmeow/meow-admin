import 'package:uuid/uuid.dart';

import '../model/product.dart';

const dailyGoods = [
  [
    "HOME COORDY Catch type slide hanger with shoulder pad",
    "",
    "https://storage.topvalu.net/assets/contents/images/product/222171/4549414149036_PC_L.jpg"
  ],
  [
    "HOME COORDY Catch type extendable bath towel hanger",
    "",
    "https://storage.topvalu.net/assets/contents/images/product/222172/4549414149043_PC_L.jpg"
  ],
  [
    "Oxygen-based bleach for clothing Non-concentrated type",
    "1000mL",
    "https://storage.topvalu.net/assets/contents/images/product/206218/4902121800049_PC_L.jpg"
  ],
  [
    "Laundry Liquid Detergent Super Clean Mild Floral",
    "1840g",
    "https://storage.topvalu.net/assets/contents/images/product/196453/4549414207750_PC_L.jpg"
  ],
  [
    "Laundry Liquid Detergent Super Clean Mild Floral…",
    "1 case",
    "https://storage.topvalu.net/assets/contents/images/product/203207/4549414216943_PC_L.jpg"
  ],
  [
    "For clothing Oxygen-based bleach Non-concentrated type Refill",
    "720mL",
    "https://storage.topvalu.net/assets/contents/images/product/198797/4549741336710_PC_L.jpg"
  ],
  [
    "Oxygen-based bleach for clothes Powder type with measuring spoon",
    "500g",
    "https://storage.topvalu.net/assets/contents/images/product/194120/4901810359127_PC_L.jpg"
  ],
  [
    "Refill bottle spray made from 100% recycled PET material",
    "50 mL",
    "https://storage.topvalu.net/assets/contents/images/product/188740/4549414143027_PC_L.jpg"
  ],
  [
    "Liquid Laundry Detergent Fragrant Super Clean Fresh…",
    "800g",
    "https://storage.topvalu.net/assets/contents/images/product/186063/4549414081749_PC_L.jpg"
  ],
  [
    "Liquid Laundry Detergent Fragrant Super Clean Fresh…",
    "12 pieces",
    "https://storage.topvalu.net/assets/contents/images/product/188121/4549414154665_PC_L.jpg"
  ],
  [
    "Laundry Detergent Fragrant Super Clean Fresh…",
    "800g",
    "https://storage.topvalu.net/assets/contents/images/product/181607/4549414081756_PC_L.jpg"
  ],
  [
    "Laundry Detergent Fragrant Super Clean Fresh…",
    "10 pieces",
    "https://storage.topvalu.net/assets/contents/images/product/188122/4549414154672_PC_L.jpg"
  ],
  [
    "HOME COORDY Laundry net M",
    "M.",
    "https://storage.topvalu.net/assets/contents/images/product/188382/4549741331739_PC_L.jpg"
  ],
  [
    "laundry basket",
    "",
    "https://storage.topvalu.net/assets/contents/images/product/188384/4549741433136_PC_L.jpg"
  ],
];

final List<Product> dailyGoodProducts =
    List.generate(dailyGoods.length, (index) {
  final list = dailyGoods[index];
  final image = list[2];
  final name = list[0];
  final desc = list[1];
  return Product(
      id: Uuid().v1(),
      photo1: image,
      photo2: image,
      photo3: image,
      name: name,
      description: desc,
      price: 2300,
      status: "Best Sellers",
      category: "All",
      tags: [],
      dateTime: DateTime.now());
});
