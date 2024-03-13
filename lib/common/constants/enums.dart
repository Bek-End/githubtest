enum SortType { star, view, starDESC, viewDESC }

extension SortTypeExtentions on SortType {
  String get displayName {
    switch (this) {
      case SortType.star:
        return 'Star (ascending)';
      case SortType.view:
        return 'View (ascending)';
      case SortType.starDESC:
        return 'Star (descending)';
      case SortType.viewDESC:
        return 'View (descending)';
    }
  }
}
