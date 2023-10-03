# EtherDart 


EtherDart is a fork from ether(don't think it maintained at the momenent) 

Ether Dart helps you 

-  Generate new memonic phrase

-  Verify Memonic phrase

-  Create wallet from PrivateKey 

-  Create wallet from Keysore json 

-  Create wallet from  memonic phrase

-  Connect to etherium block chain using web3Client 


 [ethers.js](https://github.com/ethers-io/ethers.js/).

Thanks to [web3dart](https://github.com/simolus3/web3dart) 

Thanks to [Ether](https://github.com/Hanggi/ethers) 

## Installing

Add Ethers to your pubspec.yaml file:

```yaml
dependencies:
  ether_dart: current version
```

Import Ethers in files that it will be used:

```yaml
import 'package:ether_dart/ether_dart.dart';
```

## Usage

```dart
 ///Create EtherDart without immediate connection
  final etherDart = EtherDart();

  ///Generate memomic phrase (can be called seed phrase (Eg : cow ram pig goat ))
  final memonicPhrase = etherDart.generateMemonicPhrase();
  print(memonicPhrase);

  ///Verify seed phrase
  if (memonicPhrase != null) {
    etherDart.verifyMemonicPhrase(memonicPhrase);
  }

  ///i would expose more api in the future
  ///Eg - memonicToSeedPhrase and the rest

  
```

### Wallet

```dart
///Create Wallet from private key
  final wallet = etherDart.walletFromMemonicPhrase(memonicPhrase!);

  print(wallet?.privateKey);

  ///Create wallet from private key (NOTE: Wallet from private doesnt contain memonic seed phrase)
  final walletFromPrivateKey = etherDart.walletFromPrivateKey(
      "0x7bda80e5a0873b022832654346b5313063265a2d627ff8609bcb35d714e641e0");
  print(walletFromPrivateKey?.address);

```

### Connect to web3Dart

```dart
 ///This my own RpcHost- you can create us with quickNode also
  final myHost =
      "https://bold-multi-arrow.discover.quiknode.pro/2440878aa102c59f436e9e5d84e9cea302a47356/";

  ///Connect ether to a provider
  ///Client in this case is an http client (Used in sending request to your rpc host)
  final provider = etherDart.connectProvider(Web3Client(myHost, Client()));

  ///Use the provider to perform different action
  ///Eg - getGasPrice
  ///Eg - send transaction and the rest
  final gasPrice = await provider.getGasPrice();
  print("Ether gas price ${gasPrice.getInWei}");

  ///Create an EtherDart with immediate connection
  final etherDartWithConnect = EtherDart.connect(Web3Client(myHost, Client()));

  final gasPriceWithConnect =
      await etherDartWithConnect.provider?.getGasPrice();

  print("Ether gas price with Connect ${gasPriceWithConnect?.getInWei}");

```

Feel free to contribute to this repo please 
There is a need for more packages for the web3 space with dart and flutter 