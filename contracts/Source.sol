// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface CallProxy{
    function anyCall(
        address _to,
        bytes calldata _data,
        address _fallback,
        uint256 _toChainID,
        uint256 _flags

    ) payable external;

    function calcSrcFees(
    string calldata _appID,
    uint256 _toChainID,
    uint256 _dataLength
    ) external view returns (uint256); 
    
}

contract Source {

    address payable public owneraddress;

    constructor(){
        owneraddress = payable(msg.sender);
    }

    // The Multichain anycall contract on Goerli testnet CHAIN A
    address public anycallcontractgoerli=0x965f84D915a9eFa2dD81b653e3AE736555d945f4;

    // Destination contract on Polygon Matic    CHAIN B
    address public destinationcontract=0x99BF3a5d59E7de09C7409ace11ae39e467896Bad;

    string public Message = "Hi";
    
    event ContractMessage(string msg);

    function changeMATICState(string calldata _Message) external payable{  
        //require(msg.value >= CallProxy(anycallcontractgoerli).calcSrcFees('0',80001,32), "Trying to call a smart contract function with less value than the required value statement");
        emit ContractMessage(_Message);
        if (msg.sender == owneraddress){
            CallProxy(anycallcontractgoerli).anyCall{value: msg.value}(
                destinationcontract,

                // sending the encoded bytes of the string msg and decode on the destination chain
                abi.encode(_Message), //The message 

                // 0x as fallback address because we don't have a fallback function
                address(0),

                // chainid of matic testnet
                80001,

                // Using 0 flag to pay fee on source chain
                0
                );
            }
        }

    function setDestinationContract(address _destinationcontract) external returns (bool){
        destinationcontract = _destinationcontract;
        return true;
    }
}
