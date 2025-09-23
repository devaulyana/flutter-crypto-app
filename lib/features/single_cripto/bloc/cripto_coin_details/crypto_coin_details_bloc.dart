import 'package:flutter_application_1/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_application_1/repositories/crypto_coins/models/crypto_coin_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_details_state.dart';
part 'crypto_coin_details_event.dart';

class CryptoCoinDetailsBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc(this.coinsRepository)
      : super(const CryptoCoinDetailsState()) {
    on<LoadCryptoCoinDetails>(_load);
  }

  final AbstractCoinsRepository coinsRepository;

  Future<void> _load(
    LoadCryptoCoinDetails event,
    Emitter<CryptoCoinDetailsState> emit,
  ) async {
    try {
      if (state is! CryptoCoinDetailsLoaded) {
        emit(const CryptoCoinDetailsLoading());
      }

      final coinDetails =
          await coinsRepository.getCoinDetails(event.currencyCode);

      emit(CryptoCoinDetailsLoaded(coinDetails));
    } catch (e,st) {
      emit(CryptoCoinDetailsLoadingFailure(e,st));
      GetIt.I<Talker>().handle(e,st);
    }
  }
  @override
  void onError (Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error,stackTrace);
  }
}