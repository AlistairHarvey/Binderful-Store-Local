enum SortBy {
  oldestFirst,
  mostRecent,
}

extension ToDisplayString on SortBy {
  String displayString() {
    switch (this) {
      case SortBy.mostRecent:
        return 'Most Recent';
      case SortBy.oldestFirst:
        return 'Oldest First';
    }
  }
}
