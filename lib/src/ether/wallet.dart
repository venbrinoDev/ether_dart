import 'package:ether_dart/src/crypto/formatting.dart';
import 'package:ether_dart/src/crypto/secp256k1.dart';
import 'package:ether_dart/src/utils/hdnode/hd_node.dart';
import 'package:ether_dart/src/utils/hdnode/mnemonic.dart';
import 'package:ether_dart/src/utils/wordlist.dart';

class ExternallyOwnedAccount {
  String? address;
  String? privateKey;
}

class SigningKey {
  final String curve = "secp256k1";

  final String? privateKey;
  final String? publicKey;
  final String? compressedPublicKey;

  SigningKey({
    this.privateKey,
    this.publicKey,
    this.compressedPublicKey,
  });
}

class EtherWallet implements ExternallyOwnedAccount {
  @override
  String? address;

  @override
  String? privateKey;

  final String walletPrivateKey;

  String? publicKey;

  HDNode? hdNode;

  Mnemonic? mnemonic;
  SigningKey? signingKey;

  EtherWallet({
    this.signingKey,
    this.mnemonic,
    this.address,
    this.privateKey,
    this.publicKey,
  })  : assert(privateKey != null),
        walletPrivateKey = privateKey!;

  factory EtherWallet.fromPrivateKey(String privateKey) {
    final privateKeyInt = hexToInt(privateKey);
    final publicKeyUint8List = privateKeyToPublic(privateKeyInt);
    final publicKeyHex = bytesToHex(publicKeyUint8List);
    final compressedPublicKey = privateKeyToCompressedPublic(privateKeyInt);
    final publicKey = '0x04$publicKeyHex';

    return EtherWallet(
      signingKey: SigningKey(
        privateKey: privateKey,
        compressedPublicKey: '0x02${bytesToHex(compressedPublicKey)}',
        publicKey: publicKey,
      ),
      address: getChecksumAddress(
          bytesToHex(publicKeyToAddress(publicKeyUint8List), include0x: true)),
      privateKey: privateKey,
    );
  }

  factory EtherWallet.fromHDNode(HDNode hdNode) {
    final publicKey =
        '0x04${bytesToHex(privateKeyToPublic(hexToInt(hdNode.privateKey!)))}';
    return EtherWallet(
      signingKey: SigningKey(
        privateKey: hdNode.privateKey,
        compressedPublicKey: hdNode.publicKey,
        publicKey: publicKey,
      ),
      mnemonic: hdNode.mnemonic,
      address: hdNode.address,
      privateKey: hdNode.privateKey,
      publicKey: publicKey,
    );
  }

  factory EtherWallet.fromMnemonic(
    String mnemonic, {
    String? path,
    Wordlist? wordlist,
  }) {
    path ??= defaultPath;
    return EtherWallet.fromHDNode(
        HDNode.fromMnemonic(mnemonic).derivePath(path));
  }
}
