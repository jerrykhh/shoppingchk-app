/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Shop type in your schema. */
class Shop extends amplify_core.Model {
  static const classType = const _ShopModelType();
  final String id;
  final String? _icon;
  final String? _description;
  final String? _name;
  final String? _address;
  final bool? _available;
  final double? _longitude;
  final double? _latitude;
  final String? _geohash;
  final List<Comment>? _Comments;
  final StoreCategoryType? _category;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ShopModelIdentifier get modelIdentifier {
      return ShopModelIdentifier(
        id: id
      );
  }
  
  String? get icon {
    return _icon;
  }
  
  String? get description {
    return _description;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get address {
    try {
      return _address!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get available {
    try {
      return _available!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double? get longitude {
    return _longitude;
  }
  
  double? get latitude {
    return _latitude;
  }
  
  String? get geohash {
    return _geohash;
  }
  
  List<Comment>? get Comments {
    return _Comments;
  }
  
  StoreCategoryType? get category {
    return _category;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Shop._internal({required this.id, icon, description, required name, required address, required available, longitude, latitude, geohash, Comments, category, createdAt, updatedAt}): _icon = icon, _description = description, _name = name, _address = address, _available = available, _longitude = longitude, _latitude = latitude, _geohash = geohash, _Comments = Comments, _category = category, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Shop({String? id, String? icon, String? description, required String name, required String address, required bool available, double? longitude, double? latitude, String? geohash, List<Comment>? Comments, StoreCategoryType? category}) {
    return Shop._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      icon: icon,
      description: description,
      name: name,
      address: address,
      available: available,
      longitude: longitude,
      latitude: latitude,
      geohash: geohash,
      Comments: Comments != null ? List<Comment>.unmodifiable(Comments) : Comments,
      category: category);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Shop &&
      id == other.id &&
      _icon == other._icon &&
      _description == other._description &&
      _name == other._name &&
      _address == other._address &&
      _available == other._available &&
      _longitude == other._longitude &&
      _latitude == other._latitude &&
      _geohash == other._geohash &&
      DeepCollectionEquality().equals(_Comments, other._Comments) &&
      _category == other._category;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Shop {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("icon=" + "$_icon" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("available=" + (_available != null ? _available!.toString() : "null") + ", ");
    buffer.write("longitude=" + (_longitude != null ? _longitude!.toString() : "null") + ", ");
    buffer.write("latitude=" + (_latitude != null ? _latitude!.toString() : "null") + ", ");
    buffer.write("geohash=" + "$_geohash" + ", ");
    buffer.write("category=" + (_category != null ? amplify_core.enumToString(_category)! : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Shop copyWith({String? icon, String? description, String? name, String? address, bool? available, double? longitude, double? latitude, String? geohash, List<Comment>? Comments, StoreCategoryType? category}) {
    return Shop._internal(
      id: id,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      name: name ?? this.name,
      address: address ?? this.address,
      available: available ?? this.available,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      geohash: geohash ?? this.geohash,
      Comments: Comments ?? this.Comments,
      category: category ?? this.category);
  }
  
  Shop copyWithModelFieldValues({
    ModelFieldValue<String?>? icon,
    ModelFieldValue<String?>? description,
    ModelFieldValue<String>? name,
    ModelFieldValue<String>? address,
    ModelFieldValue<bool>? available,
    ModelFieldValue<double?>? longitude,
    ModelFieldValue<double?>? latitude,
    ModelFieldValue<String?>? geohash,
    ModelFieldValue<List<Comment>?>? Comments,
    ModelFieldValue<StoreCategoryType?>? category
  }) {
    return Shop._internal(
      id: id,
      icon: icon == null ? this.icon : icon.value,
      description: description == null ? this.description : description.value,
      name: name == null ? this.name : name.value,
      address: address == null ? this.address : address.value,
      available: available == null ? this.available : available.value,
      longitude: longitude == null ? this.longitude : longitude.value,
      latitude: latitude == null ? this.latitude : latitude.value,
      geohash: geohash == null ? this.geohash : geohash.value,
      Comments: Comments == null ? this.Comments : Comments.value,
      category: category == null ? this.category : category.value
    );
  }
  
  Shop.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _icon = json['icon'],
      _description = json['description'],
      _name = json['name'],
      _address = json['address'],
      _available = json['available'],
      _longitude = (json['longitude'] as num?)?.toDouble(),
      _latitude = (json['latitude'] as num?)?.toDouble(),
      _geohash = json['geohash'],
      _Comments = json['Comments'] is List
        ? (json['Comments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _category = amplify_core.enumFromString<StoreCategoryType>(json['category'], StoreCategoryType.values),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'icon': _icon, 'description': _description, 'name': _name, 'address': _address, 'available': _available, 'longitude': _longitude, 'latitude': _latitude, 'geohash': _geohash, 'Comments': _Comments?.map((Comment? e) => e?.toJson()).toList(), 'category': amplify_core.enumToString(_category), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'icon': _icon,
    'description': _description,
    'name': _name,
    'address': _address,
    'available': _available,
    'longitude': _longitude,
    'latitude': _latitude,
    'geohash': _geohash,
    'Comments': _Comments,
    'category': _category,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ShopModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ShopModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final ICON = amplify_core.QueryField(fieldName: "icon");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final ADDRESS = amplify_core.QueryField(fieldName: "address");
  static final AVAILABLE = amplify_core.QueryField(fieldName: "available");
  static final LONGITUDE = amplify_core.QueryField(fieldName: "longitude");
  static final LATITUDE = amplify_core.QueryField(fieldName: "latitude");
  static final GEOHASH = amplify_core.QueryField(fieldName: "geohash");
  static final COMMENTS = amplify_core.QueryField(
    fieldName: "Comments",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Comment'));
  static final CATEGORY = amplify_core.QueryField(fieldName: "category");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Shop";
    modelSchemaDefinition.pluralName = "Shops";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Shop.ICON,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Shop.DESCRIPTION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Shop.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Shop.ADDRESS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Shop.AVAILABLE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Shop.LONGITUDE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Shop.LATITUDE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Shop.GEOHASH,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Shop.COMMENTS,
      isRequired: false,
      ofModelName: 'Comment',
      associatedKey: Comment.SHOPID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Shop.CATEGORY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ShopModelType extends amplify_core.ModelType<Shop> {
  const _ShopModelType();
  
  @override
  Shop fromJson(Map<String, dynamic> jsonData) {
    return Shop.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Shop';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Shop] in your schema.
 */
class ShopModelIdentifier implements amplify_core.ModelIdentifier<Shop> {
  final String id;

  /** Create an instance of ShopModelIdentifier using [id] the primary key. */
  const ShopModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'ShopModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ShopModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}