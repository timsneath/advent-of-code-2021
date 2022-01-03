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

  List<int> countDistribution(List<String> items) {
    final uniqueItems = items.toSet();

    final distribution = uniqueItems
        .map((unique) => items.where((item) => item == unique).length)
        .toList();
    return distribution;
  }

  /// Test to see whether the next path step is valid.
  ///
  /// A path is valid if the next node is a large cave (i.e. upper case), or if
  /// the next node has been visited no more than `smallCaveMaxVisits` times AND
  /// no more than one small cave has been visited more than once.
  bool isValidPath(List<String> currentPath, String nextNode) {
    if (nextNode.isUpperCase) return true;
    if (nextNode == 'start') return false;

    final smallCaves = [...currentPath, nextNode]
        .skip(1)
        .where((cave) => cave.isLowerCase)
        .toList();
    final distribution = countDistribution(smallCaves);

    if (smallCaveMaxVisits == 1) {
      // OK only if none are more than 1
      return distribution.where((element) => element > 1).isEmpty;
    } else {
      return distribution.where((v) => v == smallCaveMaxVisits).length <= 1 &&
          distribution.where((v) => v > smallCaveMaxVisits).isEmpty;
    }
  }

  Set<List<String>> findFrom(Edge startEdge, List<String> currentPath) {
    final paths = <List<String>>{};
    final nextEdges = edges
        .where((nextEdge) => startEdge.to == nextEdge.from)
        .where((nextEdge) => isValidPath(currentPath, nextEdge.to));

    for (final edge in nextEdges) {
      if (edge.to == 'end') {
        // this is a good route to the end
        paths.add([...currentPath, 'end']);
      } else {
        paths.addAll(findFrom(edge, [...currentPath, edge.to]));
      }
    }
    return paths;
  }

  // Returns a list of comma-separated paths from start to end
  Set<String> findPaths() => findFrom(Edge(null, 'start'), ['start'])
      .map((path) => path.join(','))
      .toSet();
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day12/day12.txt';
  final rawData = File(path).readAsLinesSync();

  final caveMap = CaveMap.fromRawData(rawData, 1);
  final paths = caveMap.findPaths();
  print('Number of paths if small cave can be visited once: ${paths.length}');

  final caveMap2 = CaveMap.fromRawData(rawData, 2);
  final paths2 = caveMap2.findPaths();
  print(
      'Number of paths if one small cave can be visited twice: ${paths2.length}');
}
// coverage:ignore-end
