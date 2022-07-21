// SPDX-License-Identifier:MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./ILendingPoolAddressesProvider.sol";
import "./ILendingPool.sol";
import "./WETHGateway.sol";

contract lending{
    ILendingPool public lendingpool;

    IWETHGateway ethContract;
    address aWETH = 0x87b1f4cf9BD63f7BBD3eE1aD04E8F52540349347;
    address IWETHAddress = 0xA61ca04DF33B72b235a8A28CfB535bb7A5271B70;
    address stackContract;
    // event LendingPool(address lendingPoolAddress);
    event deposit(uint amount);
    constructor() 
    {
        // stackContract = _stackContract;
        ILendingPoolAddressesProvider provider = ILendingPoolAddressesProvider(0x88757f2f99175387aB4C6a4b3067c77A695b0349);
        lendingpool = ILendingPool(provider.getLendingPool());
        // emit LendingPool(poolAddress);
        ethContract = IWETHGateway(0xA61ca04DF33B72b235a8A28CfB535bb7A5271B70); 
    }

    // function depositETH() public payable {
    //     ethContract.depositETH{value: address(this).balance}(poolAddress, address(this), 0);
    //     emit deposit(address(this).balance);
    // }

    //Token Address: 0xd0A1E359811322d97991E03f863a0C30C2cF029C
    function depositETH(address token, uint amount) public {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        IERC20(token).approve(address(lendingpool), amount);
        lendingpool.deposit(token, amount, address(this), 0);
    }

    function totalFunds() external view returns (uint256) {
        return IERC20(aWETH).balanceOf(
            address(this)
        );
    }

    function withdrawETH(address token, uint256 _amount) public {
        IERC20(aWETH).approve(IWETHAddress,_amount);
        lendingpool.withdraw(token, _amount,msg.sender);
    }
}