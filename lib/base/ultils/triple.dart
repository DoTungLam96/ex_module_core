class Triple<L, C, R> {
  Triple(this.left, this.center, this.right);

  final L left;
  final R right;
  final C center;

  @override
  String toString() => 'Triple[$left, $center,  $right]';
}
