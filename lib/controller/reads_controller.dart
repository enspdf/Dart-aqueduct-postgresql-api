import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

List reads = [
  {"title": "Title 1", "author": "Author 1", "year": 2004},
  {"title": "Title 2", "author": "Author 2", "year": 2008},
  {"title": "Title 3", "author": "Author 3", "year": 2010}
];

class ReadsController extends ResourceController {
  @Operation.get()
  Future<Response> getAllReads() async {
    return Response.ok(reads);
  }

  @Operation.get()
  Future<Response> getRead(@Bind.path("id") int id) async {
    if (id < 0 || id > reads.length - 1) {
      return Response.notFound(body: "Item not found");
    }
    return Response.ok(reads[id]);
  }

  @Operation.post()
  Future<Response> createNewRead() async {
    final Map<String, dynamic> body = request.body.as();
    reads.add(body);
    return Response.ok(body);
  }

  @Operation.put("id")
  Future<Response> updateRead(@Bind.path("id") int id) async {
    if (id < 0 || id > reads.length - 1) {
      return Response.notFound(body: "Item not found");
    }

    final Map<String, dynamic> body = request.body.as();
    reads[id] = body;

    return Response.ok("Updated read");
  }

  @Operation.delete("id")
  Future<Response> deleteRead(@Bind.path("id") int id) async {
    if (id < 0 || id > reads.length - 1) {
      return Response.notFound(body: "Item not found");
    }

    reads.removeAt(id);
    return Response.ok("Deleted read");
  }
}
