```cmd

npm init --yes
npm install --save-dev hardhat
npx hardhat
npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai

```

To compile a sol
```
cd contracts
npx hardhat compile
```

To test
```
npx hardhat test
```

Folder structure
```
-contract
-scripts
-test
--hard.config.js
```

To see all acc details
```
npx hardhat node
```