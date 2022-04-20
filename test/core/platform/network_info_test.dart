import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/core/platform/network_info.dart';

class MocConnectivity extends Mock implements Connectivity {}

void main() {
  late NetworkInfo networkInfo;
  late MocConnectivity mocConnectivity;

  setUp(() {
    mocConnectivity = MocConnectivity();
    networkInfo = NetworkInfoImpl(mocConnectivity);
  });

  group('is connected', () {
    test(
      'connected true',
      () async {
        when(() => mocConnectivity.checkConnectivity())
            .thenAnswer((r) async => ConnectivityResult.wifi);

        final result = await networkInfo.isConnected;

        verify(() => mocConnectivity.checkConnectivity());

        expect(result, true);
      },
    );
  });
}
