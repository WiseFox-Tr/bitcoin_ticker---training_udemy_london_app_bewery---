class CryptoRatio {
  String cryptoName;
  String fiatName;
  double price;

  CryptoRatio(this.cryptoName, this.fiatName, this.price);

  @override
  toString() => 'One ${this.cryptoName} currently cost ${this.price} ${this.fiatName}';
}
