// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

interface LendingPoolAddressesProvider
{
    function getLendingPool() external view returns (address);
}

interface LendingPool
{
  function deposit(
    address asset,
    uint256 amount,
    // address onBehalfOf,
    uint16 referralCode
  ) external;
}

contract lendingFund
{

    LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(address(0x88757f2f99175387aB4C6a4b3067c77A695b0349)); 
    LendingPool lendingPool = LendingPool(provider.getLendingPool());

    address daiAddress = address(0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD); 
    uint256 amount = 1000;
    uint16 referral = 0;


    function depositFunde(uint256 amount) external
    {
            IERC20(daiAddress).approve(provider.getLendingPool(), amount);

            lendingPool.deposit(daiAddress, amount, referral);
    }

   
}