import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:ether_dart/src/ether/ether.dart';
import 'package:ether_dart/src/ether/wallet.dart';
import 'package:web3dart/web3dart.dart' as web3;

class EtherDart implements Ether {
  ///Create EtherDart with no immediate connetion to web3client
  EtherDart();

  ///Create an EtherDart with a connection to web3client
  EtherDart.connect(web3.Web3Client client) : provider = client;

  ///Client for perform task on the etherium blockchain
  web3.Web3Client? provider;

  @override
  String? generateMemonicPhrase() {
    try {
      return bip39.generateMnemonic();
    } catch (e) {
      return null;
    }
  }

  @override
  bool verifyMemonicPhrase(String memonicPhrase) {
    return bip39.validateMnemonic(memonicPhrase);
  }

  @override
  EtherWallet? walletFromPrivateKey(String privateKey) {
    try {
      return EtherWallet.fromPrivateKey(privateKey);
    } catch (_) {
      return null;
    }
  }

  @override
  EtherWallet? walletFromKeystore(String json, String password) {
    try {
      final result = web3.Wallet.fromJson(json, password);

      return EtherWallet.fromPrivateKey(
          '0x${hex.encode(result.privateKey.privateKey)}');
    } catch (e) {
      return null;
    }
  }

  @override
  EtherWallet? walletFromMemonicPhrase(String memonicPhrase) {
    try {
      return EtherWallet.fromMnemonic(memonicPhrase);
    } catch (_) {
      return null;
    }
  }

  @override
  web3.Web3Client connectProvider(web3.Web3Client client) {
    provider = client;
    return provider!;
  }

  @override
  void dispose() {
    provider?.dispose();
  }
}
