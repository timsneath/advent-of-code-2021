import 'dart:io';

import '../shared/utils.dart';

class Edge {
  final String? from;
  final String to;

  const Edge(this.from, this.to);

  @override
  String toString() => '$from-$to';
}

class CaveMap {
  final List<Edge> edges;
  final int smallCaveMaxVisits;

  const CaveMap(this.edges, this.smallCaveMaxVisits);

  factory CaveMap.fromRawData(List<String> rawData, int smallCaveMaxVisits) {
    final edges = <Edge>[];
    for (final edge in rawData) {
      final fromTo = edge.split('-');

      // You can traverse in both directions, so we add both to the list of
      // edges.
      edges.add(Edge(fromTo.first, fromTo.last));
      edges.add(Edge(fromTo.last, fromTo.first));
    }
    return CaveMap(edges, smallCaveMaxVisits);
  }

  @override
  String toString() => edges.join('\n');

  Iterable<Edge> get startEdges => edges.where((edge) => edge.from == 'start');

  /// Test to see whether the next path step is valid.
  ///
  /// A path is valid if the next node is a large cave (i.e. upper case), or if
  /// the next node has been visited no more than `smallCaveMaxVisits` times.
  bool isValidPath(String nextNode, List<String> currentPath) =>
      nextNode.isUpperCase ||
      currentPath.where((n) => n == nextNode).length < smallCaveMaxVisits;

  Iterable<List<String>> findFrom(Edge startEdge, List<String> currentPath) {
    final paths = <List<String>>[];
    final nextEdges = edges
        .where((nextEdge) => startEdge.to == nextEdge.from)
        .where((nextEdge) => isValidPath(nextEdge.to, currentPath));

    for (final edge in nextEdges) {
      if (edge.to == 'end') {
        // this is a good route to the end
        paths.add([...currentPath, 'end']);
      } else if (edge.to != 'start') {
        paths.addAll(findFrom(edge, [...currentPath, edge.to]));
      }
    }
    return paths;
  }

  // Returns a list of comma-separated paths from start to end
  Iterable<String> findPaths() =>
      findFrom(Edge(null, 'start'), ['start']).map((path) => path.join(','));
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day12/day12.txt';
  final rawData = File(path).readAsLinesSync();
  final caveMap = CaveMap.fromRawData(rawData, 1);

  final paths = caveMap.findPaths();
  print('Number of paths if small cave can be visited once: ${paths.length}');
}
// coverage:ignore-end
