pragma solidity >=0.4.22 <0.6.0;

/**
 * @title Beasts
 * @dev a contract holding all the functionality and logic for beast
 */
 
contract Beasts {

    event NewBeast(uint beastId, string name, Rarity beastType, uint health);

    uint powerDigits = 16;
    uint powerModulus = 10 ** powerDigits;

    // Rarity of the beast
    enum Rarity {
        notRare,
        rare,
        superRare,
        utlraSuperRare,
        mythical  
    }

    // Type of power and it's strength
    struct power { 
        uint pwID;
        string power;
        string pwDescription;
        uint pwStrength;
    }
    mapping (uint => power) private powers;

    // Beast definition
    struct beast {
        string name;
        Rarity beastType;
        power[] powers;
        uint health;
    }

    beast[] public beasts;

    function _generateRandomPower(string memory _name) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_name)));
        return rand % powerModulus;
    }

    function createBeast(string memory _name, Rarity _beastType) public {
        uint randPower = _generateRandomPower(_name);
        _resolveBeast(randPower, _beastType);
       // _createBeast(_name, randPower);
    }
    
    function _resolveBeast(uint _randPower, Rarity _beastType) private {
        if(_beastType == Rarity.notRare)
            _notRarePowers(_randPower, _beastType);

        else if(_beastType == Rarity.rare)
            _rarePowers(_randPower, _beastType);

        else if(_beastType == Rarity.superRare)
            _superRarePowers(_randPower, _beastType);

        else if(_beastType == Rarity.utlraSuperRare)
            _utlraSuperRarePowers(_randPower, _beastType);

        else
             _mythicalPowers(_randPower, _beastType);
    } 

    function _notRarePowers(uint _randPower, Rarity _beastType) private view returns (uint) {
        uint pw = _randPower / 10**(powerDigits-2);
        uint pw1 = (pw / 10) + (pw % 10);
    }

    
}