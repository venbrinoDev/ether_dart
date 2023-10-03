import 'package:ether_dart/src/ether/wallet.dart';
import 'package:web3dart/web3dart.dart' as web3dart;

abstract class Ether {
  ///Generate memonic phrase for you Eg - money cow goat ram
  String? generateMemonicPhrase();

  ///Verify if the seed phrase is correct
  ///return type[bool]
  bool verifyMemonicPhrase(String memonicPhrase);

  /// get wallet from keystore json file and password
  /// [encoded] must be the String contents of a valid v3 Ethereum wallet json.
  EtherWallet? walletFromKeystore(String json, String password);

  /// Get wallet from memonic phrase
  /// retrun [null] if any error occurs
  EtherWallet? walletFromMemonicPhrase(String memonicPhrase);

  /// Get wallet from private Key
  EtherWallet? walletFromPrivateKey(String privateKey);

  web3dart.Web3Client connectProvider(web3dart.Web3Client client);

  void dispose();
}
