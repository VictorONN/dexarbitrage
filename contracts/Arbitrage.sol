pragma solidity ^0.6.6;

import "./UniswapV2Library.sol";
import "./interfaces/IUniswapV2Router02.sol";
import "./interfaces/IUniswapV2Pair.sol";
import "./interfaces/IUniswapV2Factory.sol";
import "./interfaces/IERC20.sol";

contract Arbitrage {
    address public factory;
    uint256 constant deadline = 10 days;
    IUniswapV2Router02 public sushiRouter;

    constructor(address _factory, address _sushiRouter) public {
        factory = _factory;
        sushiRouter = IUniswapV2Router02(_sushiRouter);
    }

    function startArbitrage(
        address token0,
        address token1,
        uint256 amount0,
        uint256 amount1
    ) external {
        address pairAddress = IUniswapV2Factory(factory).getPair(token0, token1);
        require(pairAddress != address(0), 'This pool does not exist');
        IUniswapV2Pair(pairAddress).swap(
            amount0, 
            amount1, 
            address(this),
            bytes('not empty')
        )
    }
}
