// SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;

interface InftSwapper {
    function initialize(address _token0, string[]memory _token0ID, address _token1, address _peer1, address _peer2) external;
    function peer2Setup(string[]memory _token1ID)external;
}