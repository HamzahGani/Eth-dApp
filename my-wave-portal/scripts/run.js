  const main = async () => {
    const [owner, randomPerson1, randomPerson2] = await hre.ethers.getSigners();

    // deploy contract
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
      value: hre.ethers.utils.parseEther("0.1"),
    });
    await waveContract.deployed();
  
    console.log("Contract Deployed");
    console.log("To:", waveContract.address);
    console.log("By:", owner.address);

    // get contract balance
    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract balance:", hre.ethers.utils.formatEther(contractBalance));

    // Test waves
    await waveContract.getTotalWaves(); // current wave count

    const firstWaveTxn = await waveContract.wave();
    await firstWaveTxn.wait();

    const secondWaveTxn = await waveContract.connect(randomPerson1).waveMessage("I waved with a message");
    await secondWaveTxn.wait();

    const ThirdWaveTxn = await waveContract.connect(randomPerson2).wave ();
    await ThirdWaveTxn.wait();

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);

    // get contract balance
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract balance:", hre.ethers.utils.formatEther(contractBalance));
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