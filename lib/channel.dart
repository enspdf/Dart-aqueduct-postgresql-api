import 'dart:io';
import 'fave_reads.dart';
import 'package:fave_reads/controller/reads_controller.dart';

class FaveReadsChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore =
        PostgreSQLPersistentStore("root", "", "localhost", 5432, "fave_reads");

    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint => Router()
    ..route("/reads/[:id]").link(() => ReadsController(context))
    //
    ..route("/").linkFunction((request) =>
        Response.ok("Hello World!")..contentType = ContentType.html)
    //
    ..route("/client").linkFunction((request) async {
      var client = await File("client.html").readAsString();
      return Response.ok(client)..contentType = ContentType.html;
    });
}
