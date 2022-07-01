//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
/// @notice TEAM: ENSURE TO UPDATE iNFTSWAPPER FOR ANY FUNCTION YOU MIGHT ADD HERE
contract nftSwapper {

    address factory;
    address token0;
    address token1;
    address peer1;
    address peer2;

    string[] token0ID;
    string[] token1ID;

    /**
    @notice represents the different states of swappers, locked:peer1 nfts secured, Completed:peer2 nft secured, Inactive: swap has occured
    @dev example of use in peer2setup function, note delete these comments when deploying 
    */
    enum State { Created, Locked, Completed, Inactive }
    // The state variable has a default value of the first member, `State.created`
    State public state;

    error failed(string);


    constructor() {
        factory = msg.sender;
    }

    modifier inState(State state_) {
        if (state != state_)
            revert failed('NFTSWAPPER:InvalidState');
        _;
    }

    /**
    @dev called once by the factory at time of deployment
    */
    function initialize(address _token0, string[]memory _token0ID, address _token1, address _peer1, address _peer2) external {
        if(msg.sender == factory){
            (peer1, peer2, token0, token1) = (_peer1, _peer2, _token0, _token1);
            token0ID = _token0ID;
            state = State.Created;
        }else
        {
            revert failed('NFTSAWPPER: FORBIDDEN');
        } 
       
    }

    //transfer from and swaps can occur here
    function peer2Setup(string[]memory _token1ID)external inState(State.Locked){
        if(msg.sender==peer2)
        {
            token1ID = _token1ID;
        }else
        {
            revert failed('NFTSAWPPER: MUST BE PEER2');
        }
        
    }

}