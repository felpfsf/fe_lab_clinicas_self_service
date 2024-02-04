import 'package:json_annotation/json_annotation.dart';

part 'patient_address_model.g.dart';

@JsonSerializable()
class PatientAddressModel {
  PatientAddressModel({
    required this.cep,
    required this.streetAddress,
    required this.number,
    required this.addressComplement,
    required this.state,
    required this.city,
    required this.district,
  });

  final String cep;
  @JsonKey(name: 'street_address')
  final String streetAddress;
  final String number;
  @JsonKey(name: 'address_complement', defaultValue: '')
  final String addressComplement;
  final String state;
  final String city;
  final String district;

  // comando fu-class-json-serializable
  // Para gerar é preciso utilizar o build runner
  // dart pub run build_runner watch -d

  factory PatientAddressModel.fromJson(Map<String, dynamic> json) =>
      _$PatientAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAddressModelToJson(this);
}
