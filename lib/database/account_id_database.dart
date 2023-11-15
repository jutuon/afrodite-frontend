


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/base_database.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

abstract class AccountIdDatabase extends BaseDatabase {
  static const String accountIdTableName = "account_id";

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE account_id(
        id INTEGER PRIMARY KEY,
        uuid TEXT NOT NULL UNIQUE
      )
    """);
  }

  @override
  Future<void> init() async {
    // Create database or run migrations
    await getOrOpenDatabase(deleteBeforeOpenForDevelopment: false);
  }

  Future<void> clearAccountIds() async {
    await runAction((db) async {
      return await db.delete(accountIdTableName);
    });
  }

  Future<int?> accountIdCount() async {
    return await runAction((db) async {
      return firstIntValue(
        await db.query(
          accountIdTableName,
          columns: ["COUNT(id)"]),
        );
    });
  }

  Future<void> insertAccountId(AccountId accountId) async {
    await runAction((db) async {
      return await db.insert(
        accountIdTableName,
        AccountIdEntry(accountId.accountId).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<void> insertAccountIdList(List<AccountId>? accountIdList) async {
    for (final AccountId accountId in accountIdList ?? []) {
      await insertAccountId(accountId);
    }
  }

  Future<void> removeAccountId(AccountId accountId) async {
    await runAction((db) async {
      return await db.delete(
        accountIdTableName,
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
    });
  }

  Future<bool> exists(AccountId accountId) async {
    return await runAction((db) async {
      final data = await db.query(
        accountIdTableName,
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
      return data.isNotEmpty;
    }) ?? false;
  }

  /// Returns null in case of an error.
  Future<List<AccountId>?> getAccountIdList(int startIndex, int? limit) async {
    return await runAction((db) async {
      final result = await db.query(
        accountIdTableName,
        columns: ["uuid"],
        orderBy: "id",
        limit: limit,
        offset: startIndex,
      );
      return result.map((e) => AccountIdEntry.fromMap(e).toAccountid()).toList();
    });
  }
}

class AccountIdEntry {
  final String uuid;
  AccountIdEntry(this.uuid);

  Map<String, Object?> toMap() {
    return {
      "uuid": uuid,
    };
  }

  AccountIdEntry.fromMap(Map<String, Object?> map):
    uuid = map["uuid"] as String;

  AccountId toAccountid() {
    return AccountId(
      accountId: uuid,
    );
  }

  @override
  String toString() {
    return "AccountIdEntry(uuid: $uuid)";
  }
}
