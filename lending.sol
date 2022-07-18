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

  function withdraw(address asset, uint256 amount, address to) external;
}

contract lendingFund
{

    LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(address(0x88757f2f99175387aB4C6a4b3067c77A695b0349)); 
    LendingPool lendingPool = LendingPool(provider.getLendingPool());

    address linkAddress = address(0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD); 
    uint256 amount = 1000;
    uint16 referral = 0;
    uint depositAmount;
    address User;

    constructor(address _user)
    {
        User = _user;
    }
     


    function depositFunde(uint256 _amount) external
    {
            depositAmount = amount;
            IERC20(linkAddress).approve(provider.getLendingPool(), depositAmount);

            lendingPool.deposit(linkAddress, amount, referral);
    }

    function withdrawFund() external
    {
        lendingPool.withdraw(linkAddress, depositAmount, User);
    }

   
}