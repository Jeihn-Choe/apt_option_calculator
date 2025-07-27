// apartment_option_model.dart
class ApartmentOptionModel {
  final String type;
  final int expansionPrice;
  final bool bedSep;
  final bool alphaSep;
  final List<OptionModel> option;

  ApartmentOptionModel({
    required this.type,
    required this.expansionPrice,
    required this.bedSep,
    required this.alphaSep,
    required this.option,
  });

  factory ApartmentOptionModel.fromJson(Map<String, dynamic> json) {
    return ApartmentOptionModel(
      type: json['type'],
      expansionPrice: json['expansionPrice'],
      bedSep: json['bedSep'],
      alphaSep: json['alphaSep'],
      option: (json['option'] as List)
          .map((item) => OptionModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'expansionPrice': expansionPrice,
      'bedSep': bedSep,
      'alphaSep': alphaSep,
      'option': option.map((item) => item.toJson()).toList(),
    };
  }
}

class OptionModel {
  final int id;
  final String? desc;
  final List<DetailedOptionModel>? detailedOption;

  OptionModel({required this.id, this.desc, this.detailedOption});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      desc: json['desc'],
      detailedOption: json['detailedOption'] != null
          ? (json['detailedOption'] as List)
                .map((item) => DetailedOptionModel.fromJson(item))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desc': desc,
      'detailedOption': detailedOption?.map((item) => item.toJson()).toList(),
    };
  }
}

class DetailedOptionModel {
  final String desc;
  final int price;

  DetailedOptionModel({required this.desc, required this.price});

  factory DetailedOptionModel.fromJson(Map<String, dynamic> json) {
    return DetailedOptionModel(desc: json['desc'], price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {'desc': desc, 'price': price};
  }
}
