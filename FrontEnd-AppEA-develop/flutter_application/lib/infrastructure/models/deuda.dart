import 'package:flutter_application/infrastructure/models/user.dart';

class Deuda {
  final User userBeneficiario;
  final User userEndeudado;
  final num deuda;

  Deuda(this.userBeneficiario, this.userEndeudado, this.deuda);
}