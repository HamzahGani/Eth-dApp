  const main = async () => {
    const [owner, randomPerson1, randomPerson2] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
  
    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);
  
    await waveContract.getTotalWaves();

    const firstWaveTxn = await waveContract.wave();
    await firstWaveTxn.wait();

    const secondWaveTxn = await waveContract.connect(randomPerson1).wave();
    await secondWaveTxn.wait();

    const ThirdWaveTxn = await waveContract.connect(randomPerson2).wave();
    await ThirdWaveTxn.wait();
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0); // exit Node process without error
    } catch (error) {
      console.log(error);
      process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
    }
  };
  
  runMain();