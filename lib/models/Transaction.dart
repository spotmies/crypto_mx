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

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Transaction type in your schema. */
@immutable
class Transaction extends Model {
  static const classType = const _TransactionModelType();
  final String id;
  final String? _username;
  final String? _transactionId;
  final double? _percentage;
  final int? _daysToHold;
  final double? _amount;
  final String? _timeStamp;
  final bool? _approve;
  final String? _withdrawTimeLocal;
  final bool? _withDrawPrinciple;
  final bool? _transactionStatus;
  final String? _coinName;
  final bool? _withDrawEarning;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get transactionId {
    try {
      return _transactionId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get percentage {
    try {
      return _percentage!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get daysToHold {
    try {
      return _daysToHold!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get amount {
    try {
      return _amount!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get timeStamp {
    try {
      return _timeStamp!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get approve {
    try {
      return _approve!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get withdrawTimeLocal {
    try {
      return _withdrawTimeLocal!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get withDrawPrinciple {
    try {
      return _withDrawPrinciple!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get transactionStatus {
    try {
      return _transactionStatus!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get coinName {
    try {
      return _coinName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get withDrawEarning {
    try {
      return _withDrawEarning!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Transaction._internal({required this.id, required username, required transactionId, required percentage, required daysToHold, required amount, required timeStamp, required approve, required withdrawTimeLocal, required withDrawPrinciple, required transactionStatus, required coinName, required withDrawEarning, createdAt, updatedAt}): _username = username, _transactionId = transactionId, _percentage = percentage, _daysToHold = daysToHold, _amount = amount, _timeStamp = timeStamp, _approve = approve, _withdrawTimeLocal = withdrawTimeLocal, _withDrawPrinciple = withDrawPrinciple, _transactionStatus = transactionStatus, _coinName = coinName, _withDrawEarning = withDrawEarning, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Transaction({String? id, required String username, required String transactionId, required double percentage, required int daysToHold, required double amount, required String timeStamp, required bool approve, required String withdrawTimeLocal, required bool withDrawPrinciple, required bool transactionStatus, required String coinName, required bool withDrawEarning}) {
    return Transaction._internal(
      id: id == null ? UUID.getUUID() : id,
      username: username,
      transactionId: transactionId,
      percentage: percentage,
      daysToHold: daysToHold,
      amount: amount,
      timeStamp: timeStamp,
      approve: approve,
      withdrawTimeLocal: withdrawTimeLocal,
      withDrawPrinciple: withDrawPrinciple,
      transactionStatus: transactionStatus,
      coinName: coinName,
      withDrawEarning: withDrawEarning);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Transaction &&
      id == other.id &&
      _username == other._username &&
      _transactionId == other._transactionId &&
      _percentage == other._percentage &&
      _daysToHold == other._daysToHold &&
      _amount == other._amount &&
      _timeStamp == other._timeStamp &&
      _approve == other._approve &&
      _withdrawTimeLocal == other._withdrawTimeLocal &&
      _withDrawPrinciple == other._withDrawPrinciple &&
      _transactionStatus == other._transactionStatus &&
      _coinName == other._coinName &&
      _withDrawEarning == other._withDrawEarning;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Transaction {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("transactionId=" + "$_transactionId" + ", ");
    buffer.write("percentage=" + (_percentage != null ? _percentage!.toString() : "null") + ", ");
    buffer.write("daysToHold=" + (_daysToHold != null ? _daysToHold!.toString() : "null") + ", ");
    buffer.write("amount=" + (_amount != null ? _amount!.toString() : "null") + ", ");
    buffer.write("timeStamp=" + "$_timeStamp" + ", ");
    buffer.write("approve=" + (_approve != null ? _approve!.toString() : "null") + ", ");
    buffer.write("withdrawTimeLocal=" + "$_withdrawTimeLocal" + ", ");
    buffer.write("withDrawPrinciple=" + (_withDrawPrinciple != null ? _withDrawPrinciple!.toString() : "null") + ", ");
    buffer.write("transactionStatus=" + (_transactionStatus != null ? _transactionStatus!.toString() : "null") + ", ");
    buffer.write("coinName=" + "$_coinName" + ", ");
    buffer.write("withDrawEarning=" + (_withDrawEarning != null ? _withDrawEarning!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Transaction copyWith({String? id, String? username, String? transactionId, double? percentage, int? daysToHold, double? amount, String? timeStamp, bool? approve, String? withdrawTimeLocal, bool? withDrawPrinciple, bool? transactionStatus, String? coinName, bool? withDrawEarning}) {
    return Transaction._internal(
      id: id ?? this.id,
      username: username ?? this.username,
      transactionId: transactionId ?? this.transactionId,
      percentage: percentage ?? this.percentage,
      daysToHold: daysToHold ?? this.daysToHold,
      amount: amount ?? this.amount,
      timeStamp: timeStamp ?? this.timeStamp,
      approve: approve ?? this.approve,
      withdrawTimeLocal: withdrawTimeLocal ?? this.withdrawTimeLocal,
      withDrawPrinciple: withDrawPrinciple ?? this.withDrawPrinciple,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      coinName: coinName ?? this.coinName,
      withDrawEarning: withDrawEarning ?? this.withDrawEarning);
  }
  
  Transaction.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _transactionId = json['transactionId'],
      _percentage = (json['percentage'] as num?)?.toDouble(),
      _daysToHold = (json['daysToHold'] as num?)?.toInt(),
      _amount = (json['amount'] as num?)?.toDouble(),
      _timeStamp = json['timeStamp'],
      _approve = json['approve'],
      _withdrawTimeLocal = json['withdrawTimeLocal'],
      _withDrawPrinciple = json['withDrawPrinciple'],
      _transactionStatus = json['transactionStatus'],
      _coinName = json['coinName'],
      _withDrawEarning = json['withDrawEarning'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'transactionId': _transactionId, 'percentage': _percentage, 'daysToHold': _daysToHold, 'amount': _amount, 'timeStamp': _timeStamp, 'approve': _approve, 'withdrawTimeLocal': _withdrawTimeLocal, 'withDrawPrinciple': _withDrawPrinciple, 'transactionStatus': _transactionStatus, 'coinName': _coinName, 'withDrawEarning': _withDrawEarning, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "transaction.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField TRANSACTIONID = QueryField(fieldName: "transactionId");
  static final QueryField PERCENTAGE = QueryField(fieldName: "percentage");
  static final QueryField DAYSTOHOLD = QueryField(fieldName: "daysToHold");
  static final QueryField AMOUNT = QueryField(fieldName: "amount");
  static final QueryField TIMESTAMP = QueryField(fieldName: "timeStamp");
  static final QueryField APPROVE = QueryField(fieldName: "approve");
  static final QueryField WITHDRAWTIMELOCAL = QueryField(fieldName: "withdrawTimeLocal");
  static final QueryField WITHDRAWPRINCIPLE = QueryField(fieldName: "withDrawPrinciple");
  static final QueryField TRANSACTIONSTATUS = QueryField(fieldName: "transactionStatus");
  static final QueryField COINNAME = QueryField(fieldName: "coinName");
  static final QueryField WITHDRAWEARNING = QueryField(fieldName: "withDrawEarning");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Transaction";
    modelSchemaDefinition.pluralName = "Transactions";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.TRANSACTIONID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.PERCENTAGE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.DAYSTOHOLD,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.AMOUNT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.TIMESTAMP,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.APPROVE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.WITHDRAWTIMELOCAL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.WITHDRAWPRINCIPLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.TRANSACTIONSTATUS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.COINNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.WITHDRAWEARNING,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _TransactionModelType extends ModelType<Transaction> {
  const _TransactionModelType();
  
  @override
  Transaction fromJson(Map<String, dynamic> jsonData) {
    return Transaction.fromJson(jsonData);
  }
}