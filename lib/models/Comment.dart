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

/** This is an auto generated class representing the Comment type in your schema. */
class Comment extends amplify_core.Model {
  static const classType = const _CommentModelType();
  final String id;
  final String? _userId;
  final String? _description;
  final CommentRate? _rate;
  final User? _User;
  final String? _shopID;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _commentUserId;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;

  CommentModelIdentifier get modelIdentifier {
    return CommentModelIdentifier(id: id);
  }

  String get userId {
    try {
      return _userId!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String get description {
    try {
      return _description!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  CommentRate? get rate {
    return _rate;
  }

  User? get User {
    return _User;
  }

  String get shopID {
    try {
      return _shopID!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }

  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  String? get commentUserId {
    return _commentUserId;
  }

  const Comment._internal(
      {required this.id,
      required userId,
      required description,
      rate,
      User,
      required shopID,
      createdAt,
      updatedAt,
      commentUserId})
      : _userId = userId,
        _description = description,
        _rate = rate,
        _User = User,
        _shopID = shopID,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _commentUserId = commentUserId;

  factory Comment(
      {String? id,
      required String userId,
      required String description,
      CommentRate? rate,
      User? User,
      required String shopID,
      String? commentUserId}) {
    return Comment._internal(
        id: id == null ? amplify_core.UUID.getUUID() : id,
        userId: userId,
        description: description,
        rate: rate,
        User: User,
        shopID: shopID,
        commentUserId: commentUserId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
        id == other.id &&
        _userId == other._userId &&
        _description == other._description &&
        _rate == other._rate &&
        _User == other._User &&
        _shopID == other._shopID &&
        _commentUserId == other._commentUserId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Comment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("rate=" +
        (_rate != null ? amplify_core.enumToString(_rate)! : "null") +
        ", ");
    buffer.write("shopID=" + "$_shopID" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (_updatedAt != null ? _updatedAt!.format() : "null") +
        ", ");
    buffer.write("commentUserId=" + "$_commentUserId");
    buffer.write("}");

    return buffer.toString();
  }

  Comment copyWith(
      {String? userId,
      String? description,
      CommentRate? rate,
      User? User,
      String? shopID,
      String? commentUserId}) {
    return Comment._internal(
        id: id,
        userId: userId ?? this.userId,
        description: description ?? this.description,
        rate: rate ?? this.rate,
        User: User ?? this.User,
        shopID: shopID ?? this.shopID,
        commentUserId: commentUserId ?? this.commentUserId);
  }

  Comment copyWithModelFieldValues(
      {ModelFieldValue<String>? userId,
      ModelFieldValue<String>? description,
      ModelFieldValue<CommentRate?>? rate,
      ModelFieldValue<User?>? User,
      ModelFieldValue<String>? shopID,
      ModelFieldValue<String?>? commentUserId}) {
    return Comment._internal(
        id: id,
        userId: userId == null ? this.userId : userId.value,
        description: description == null ? this.description : description.value,
        rate: rate == null ? this.rate : rate.value,
        User: User == null ? this.User : User.value,
        shopID: shopID == null ? this.shopID : shopID.value,
        commentUserId:
            commentUserId == null ? this.commentUserId : commentUserId.value);
  }

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _userId = json['userId'],
        _description = json['description'],
        _rate = amplify_core.enumFromString<CommentRate>(
            json['rate'], CommentRate.values),
        _User = json['User']?['serializedData'] != null
            ? User.fromJson(
                new Map<String, dynamic>.from(json['User']['serializedData']))
            : null,
        _shopID = json['shopID'],
        _createdAt = json['createdAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['updatedAt'])
            : null,
        _commentUserId = json['commentUserId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': _userId,
        'description': _description,
        'rate': amplify_core.enumToString(_rate),
        'User': _User?.toJson(),
        'shopID': _shopID,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format(),
        'commentUserId': _commentUserId
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'userId': _userId,
        'description': _description,
        'rate': _rate,
        'User': _User,
        'shopID': _shopID,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'commentUserId': _commentUserId
      };

  static final amplify_core.QueryModelIdentifier<CommentModelIdentifier>
      MODEL_IDENTIFIER =
      amplify_core.QueryModelIdentifier<CommentModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final USERID = amplify_core.QueryField(fieldName: "userId");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final RATE = amplify_core.QueryField(fieldName: "rate");
  static final USER = amplify_core.QueryField(
      fieldName: "User",
      fieldType: amplify_core.ModelFieldType(
          amplify_core.ModelFieldTypeEnum.model,
          ofModelName: 'User'));
  static final SHOPID = amplify_core.QueryField(fieldName: "shopID");
  static final COMMENTUSERID =
      amplify_core.QueryField(fieldName: "commentUserId");
  static var schema = amplify_core.Model.defineSchema(
      define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comment";
    modelSchemaDefinition.pluralName = "Comments";

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

    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["shopID"], name: "byShop")
    ];

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Comment.USERID,
        isRequired: true,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Comment.DESCRIPTION,
        isRequired: true,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Comment.RATE,
        isRequired: false,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
        key: Comment.USER,
        isRequired: false,
        ofModelName: 'User',
        associatedKey: User.ID));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Comment.SHOPID,
        isRequired: true,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
            fieldName: 'createdAt',
            isRequired: false,
            isReadOnly: true,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
            fieldName: 'updatedAt',
            isRequired: false,
            isReadOnly: true,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Comment.COMMENTUSERID,
        isRequired: false,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));
  });
}

class _CommentModelType extends amplify_core.ModelType<Comment> {
  const _CommentModelType();

  @override
  Comment fromJson(Map<String, dynamic> jsonData) {
    return Comment.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'Comment';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Comment] in your schema.
 */
class CommentModelIdentifier implements amplify_core.ModelIdentifier<Comment> {
  final String id;

  /** Create an instance of CommentModelIdentifier using [id] the primary key. */
  const CommentModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => (<String, dynamic>{entry.key: entry.value}))
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'CommentModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is CommentModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
