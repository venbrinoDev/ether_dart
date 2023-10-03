import 'package:ether_dart/ether_dart.dart';
import 'package:ether_dart/src/ether/wallet.dart';

import 'package:test/test.dart';

void main() {
  group("Phrase Generation and verification ", () {
    late EtherDart etherDart;

    late String? memonicPhrase;

    setUpAll(() {
      etherDart = EtherDart();
      memonicPhrase = etherDart.generateMemonicPhrase();
    });

    test("Test memonic pharse is not Null ", () {
      expect(memonicPhrase, isNotNull);
    });

    test("Test memonic pharse is not equal the same ", () {
      expect(memonicPhrase, isNot(equals(etherDart.generateMemonicPhrase())));
    });

    test("Test Verify Memonic Pharse", () {
      expect(etherDart.verifyMemonicPhrase(memonicPhrase!), true);
    });

    test("Test Verify Memonic Pharse", () {
      expect(
        etherDart.verifyMemonicPhrase("ddd"),
        false,
      );
    });

    tearDownAll(() {
      etherDart.dispose();
    });
  });

  group("Wallet Generated from private key ", () {
    late EtherDart etherDart;
    late EtherWallet? wallet;

    setUpAll(() {
      etherDart = EtherDart();
    });

    setUp(() {
      wallet = etherDart.walletFromPrivateKey(
          "0x7bda80e5a0873b022832654346b5313063265a2d627ff8609bcb35d714e641e0");
    });

    test("Test Generate Wallet from private key is not null ", () {
      expect(wallet, isNotNull);
    });

    test("Test Generate Wallet has no seed pharse  ", () {
      expect(wallet?.mnemonic?.phrase, null);
    });

    test("Test Generate Wallet has no seed pharse  ", () {
      expect(wallet?.mnemonic?.phrase, null);
    });

    tearDownAll(() {
      etherDart.dispose();
    });
  });
}
