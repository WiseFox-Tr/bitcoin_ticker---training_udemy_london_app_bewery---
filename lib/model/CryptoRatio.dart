class CryptoRatio {
  String cryptoName;
  String fiatName;
  double rate;

  CryptoRatio(this.cryptoName, this.fiatName, this.rate);

  @override
  toString() {
    return 'One ${this.cryptoName} currently cost ${this.rate} ${this.fiatName} : ';
  }
}
