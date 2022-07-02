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
           pair= creator(_token0,_token0ID,_token1,_peer2);
        //  bytes memory bytecode = type(nftSwapper).creationCode;
        //  bytes32 salt = keccak256(abi.encodePacked(_token0,_token1));
        //  address sender = msg.sender;
        //  address pairs;
        //  assembly{
        //      pair:= create2(0, sender, mload(bytecode), salt)
        //      pairs:=pair
        //  }
        //  InftSwapper(pairs).initialize(_token0, _token0ID, _token1, msg.sender, _peer2);
       
        }else 
        {
            reverter();
        }
    }

    function creator(address _token0, string[]memory _token0ID, address _token1, address _peer2)internal returns(address)
    {
        nftSwapper pair= new nftSwapper();
        InftSwapper(address(pair)).initialize(_token0, _token0ID, _token1, msg.sender, _peer2);
        emit PairCreated(_token0, _token1, address(pair));
        return address(pair);

    }

    function reverter()internal pure
    {
        revert failed('NFTSAWPPER: INVALID_INPUT');
    }
}
