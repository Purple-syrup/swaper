//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import './nftSwapper.sol';
import './InftSwapper.sol';
contract swapperFactory{

    error failed(string);

    event PairCreated(address indexed token0, address indexed token1, address pair);

    function createPair(address _token0, string[]memory _token0ID, address _token1, address _peer2) external returns (address pair)
    {
        if(_peer2!=address(0)&&_token0!=address(0)&&_token1!=address(0))
        {
        creator(_token0, _token1);
        InftSwapper(pair).initialize(_token0, _token0ID, _token1, msg.sender, _peer2);
        emit PairCreated(_token0, _token1, pair);
        }else 
        {
            reverter();
        }
    }

    function creator(address token0, address token1)internal returns(address pair)
    {
        bytes memory bytecode = type(nftSwapper).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0,token1));
        address sender = msg.sender;
        assembly{
            pair:= create2(0, sender, mload(bytecode), salt)
        }

    }

    function reverter()internal pure
    {
        revert failed('NFTSAWPPER: INVALID_INPUT');
    }
}