//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "./IUniswapV2Factory.sol";
import "./IUniswapV2Pair.sol";
import "./IUniswapV2Router.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract Uniswap {
    address public constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address public constant WETH = 0xd0A1E359811322d97991E03f863a0C30C2cF029C;

    event LiquidityRes(uint amountA,uint amountB,uint liquidity);

    function addLiquidity(address tokenA, address tokenB, uint amountADesired, uint amountBDesired, uint amountAMin, uint amountBMin) public {
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountADesired);
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountBDesired);
        
        IERC20(tokenA).approve(UNISWAP_V2_ROUTER, amountADesired);
        IERC20(tokenB).approve(UNISWAP_V2_ROUTER, amountBDesired);

        (uint amountA, uint amountB, uint liquidity) = IUniswapV2Router02(UNISWAP_V2_ROUTER).addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, msg.sender, block.timestamp + 1000);
        emit LiquidityRes(amountA, amountB, liquidity);
    }

    function swap(address tokenIn, address tokenOut, uint amount, address _to) public {
        uint amountIn = amount;
        uint amountOut = amount;
        IERC20(tokenIn).transferFrom(msg.sender, address(this), amount);
        IERC20(tokenIn).approve(UNISWAP_V2_ROUTER, amount);
        
        address[] memory path;
 
        path = new address[](2);
        path[0] = tokenIn;
        path[1] = tokenOut;
    
        IUniswapV2Router02(UNISWAP_V2_ROUTER).swapExactTokensForTokens(amountIn, amountOut, path, _to, block.timestamp + 1000);
    }

    function getAmountOutMin(address _tokenIn, address _tokenOut, uint _amountIn) external view returns (uint) {
        address[] memory path;

        path = new address[](2);
        path[0] = _tokenIn;
        path[1] = _tokenOut;

        uint[] memory amountOutMins = IUniswapV2Router02(UNISWAP_V2_ROUTER).getAmountsOut(_amountIn, path);

        return amountOutMins[path.length - 1];
    }

    // function distributeFund() public
    // {

    // }
}