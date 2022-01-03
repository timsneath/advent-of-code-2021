import 'dart:io';

import '../shared/utils.dart';

class Edge {
  final String from;
  final String to;

  const Edge(this.from, this.to);

  @override
  String toString() => '$from-$to';
}

class CaveMap {
  final List<Edge> edges;

  const CaveMap(this.edges);

  factory CaveMap.fromRawData(List<String> rawData) {
    final edges = <Edge>[];
    for (final edge in rawData) {
      final fromTo = edge.split('-');

      // You can traverse in both directions, so we add both to the list of
      // edges.
      edges.add(Edge(fromTo.first, fromTo.last));
      edges.add(Edge(fromTo.last, fromTo.first));
    }
    return CaveMap(edges);
  }

  @override
  String toString() => edges.join('\n');

  Iterable<Edge> get startEdges => edges.where((edge) => edge.from == 'start');

  bool isValidPath(String node, List<String> currentPath) =>
      !node.isLowerCase || !currentPath.contains(node);

  Iterable<List<String>> findFrom(Edge startEdge, List<String> currentPath) {
    final paths = <List<String>>[];
    final nextEdges = edges
        .where((nextEdge) => startEdge.to == nextEdge.from)
        .where((nextEdge) => isValidPath(nextEdge.to, currentPath));

    for (final edge in nextEdges) {
      if (edge.to == 'end') {
        // this is a good route to the end
        paths.add(currentPath..add('end'));
      } else {
        currentPath.add(startEdge.from);
        paths.addAll(findFrom(edge, currentPath));
      }
    }
    return paths;
  }

  // Returns a list of comma-separated paths from start to end
  Iterable<String> findPaths() {
    final paths = <List<String>>[];
    for (final edge in startEdges) {
      paths.addAll(findFrom(edge, []));
    }
    return paths.map((pathList) => pathList.join(','));
  }
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day12/day12.txt';
  final rawData = File(path).readAsLinesSync();
  final caveMap = CaveMap.fromRawData(rawData);

  final paths = caveMap.findPaths();
  print(paths.length);
}
// coverage:ignore-end
