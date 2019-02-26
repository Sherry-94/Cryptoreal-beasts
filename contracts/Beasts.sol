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
        string power;
        string pwDescription;
        uint pwStrength;
    }

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
        _resolvePower(randPower, _beastType);
       // _createBeast(_name, randPower);
    }

    function _resolvePower(uint _randPower, Rarity _beastType) private {
        if(_beastType == notRare)
            _notRarePowers(_randPower);

        else if(_beastType == rare)
            _rarePowers(_randPower);

        else if(_beastType == superRare)
            _superRarePowers(_randPower);

        else if(_beastType == utlraSuperRare)
            _utlraSuperRarePowers(_randPower);

        else
             _mythicalPowers(_randPower);
    } 

    
}