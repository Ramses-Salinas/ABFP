enum TipoMoneda {
  Sol,
  Dolar,
  Euro,
}

extension TipoMonedaExtension on TipoMoneda {
  String getCurrencySymbol() {
    switch (this) {
      case TipoMoneda.Sol:
        return 'S/';
      case TipoMoneda.Dolar:
        return '\$';
      case TipoMoneda.Euro:
        return '€';
      default:
        return '';
    }
  }
}

