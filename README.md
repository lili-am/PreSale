# Lili Smart Contacts Crowdsale

We used [OpenZeppelin](https://github.com/OpenZeppelin/zeppelin-solidity/) smart contracts as they are gold standards for solidity and ICO development.

## Contracts

#### Crowdsale

This contract is the one receiving the tokens, and is connected to the *WhitelistedGateway* and *PendingContributions*. Depending if the contributor is whitelisted or not, the funds are sent to the smart contract *WhitelistedGateway* or the smart contract *PendingContributions*. Funds coming from whitelisted contributors are finally sent to the vault address.

#### Gateway

The gateway is connected to the *Whitelist*. *Crowdsale* and *PendingContributions* can communicate with the gateway to know if a contributor is whitelisted or not.

#### PendingContributions

If the user is not whitelisted, the contributions from *Crowdsale* are sent to this contract. If the user gets whitelisted later, the funds can be sent to the vault directly from this contract manually by contract's owner.

#### LiliToken

The Lili token is a standard ERC20 token, which is also burnable.

#### LiliVestingTrustee

This smart contract manages the vesting for founders. There is 5 parameters in this vesting :
- **The address** of the future owner of tokens,
- The **number of tokens** granted,
- The **first block**, to indicate when the vesting starts,
- The **last block**, to indicate when the vesting ends,
- A **cliff block**, to indicate when the owner can start receiving a part of his tokens.


This is how the vesting contract works :
```
+					|
+					|
+					|                     °   °   °   °   °   ° 
+                   |                  °
+                   |               °
+                   |            °
+   Cannot get      |         °
+   tokens.         |      °
+                   |   °
+                   |°
+                 . |
+              .    |	Can receive tokens gradually.
+           .       |	At the endBlock, the maximum token
+        .          |	amount is reached.
+     .             |
+  .                |
+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
|                   |                       |
startBlock          cliffBlock              endBlock   
```      

## Develop

Contracts have been written in Solidity, and tested using Truffle and Ganache. 
They have also been tested on Ropsten.