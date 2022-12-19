// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library DonationHelper {

    function getLatestEthToUsd() internal view returns (uint256) {
        //TestNet: Goerli Testnet
        //ChainLink Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        ( , int price, , , ) = priceFeed.latestRoundData(); // $1,184.75982094 (as of the time)
        return uint256(price * 1e10);  // 1 ** 10000000000
    }

    function getConversionRate(uint256 _amount) internal view returns (uint256) {
        uint256 ethPrice = getLatestEthToUsd();
        uint256 getEthUsd = (ethPrice * _amount) / 1e18;
        return getEthUsd;
    }

}