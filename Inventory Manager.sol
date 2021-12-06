pragma solidity ^0.8.0;

contract InventoryManager{
    
    // to maintain history of the contract owner
    address _contract_owner;

    constructor(){
        _contract_owner = msg.sender;
        ownerCount = 0;
        assetCount = 0;
    }
    
    // mainting assets and asset count
    uint256 public assetCount;
    mapping(uint => Asset) public assets;
  
    // mainting owner and owner count
    uint256 public ownerCount;
    mapping(address => Owner) public owners;

    // An asset object represnting a real world object digitally
    struct Asset{
        uint _asset_id;
        address _asset_owner;
        string _asset_description;
        uint _asset_price;
    }

    // An owner object represnting a real world owner of an asset
    struct Owner{
        address _id ;
        bool _exists ;
        string _firstName;
        string _lastName;
                
    }

    function addOwner(string memory firstn,string memory lastn) public  {
        
        // code below makes sure that one account can only make 1 owner entity on the blockchain
        require( owners[ msg.sender]._exists  ==  false );
        
        // If the account was not previously an owner on the blockchain then create an owner mapping
        owners[msg.sender] = Owner(msg.sender, true , firstn, lastn);
        ownerCount += 1;
    }

    // Adding asset to the blockchain via contract
    function addAsset(string memory _asset_description,uint _pric) public {
        
        // make sure that the account user exists as an owner through the contract
        require( owners[ msg.sender]._exists  ==  true );
        
        assets[assetCount] = Asset(assetCount,msg.sender,_asset_description,_pric);
        assetCount += 1;
    }

    // transferring account ownership ( a very naive trading function )
    function transferAsset(address transfer_to , uint _addres_id ) public {

        // confirm asset ownership
        require( assets[_addres_id]._asset_owner == msg.sender );

        // transfer asset
        assets[_addres_id]._asset_owner = transfer_to;

    }
}