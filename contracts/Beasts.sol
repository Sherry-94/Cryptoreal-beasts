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

    // keeping the track of all the available powers, 20 for now
    mapping (uint => mapping(uint => power)) private powers;

    // Beast definition
    struct beast {
        string name;
        Rarity beastType;
        power[] powersOwned;
        uint health;
    }

    power[] public powersOwned;
    beast[] public beasts;

    /**
   * @dev createBeast responsible of creating a beast, calls a no. of internal functions.
   * @param _name from client side, name of the beast
   * @param _beastType from client side, rarity of the beast wanted
   */
    function createBeast(string memory _name, Rarity _beastType) public {
        uint randSq = _generateRandomSequence(_name);
        _resolveBeast(randSq, _beastType, _name);
    }

    /**
   * @dev _resolveBeast evaluates the beast, upon its rarity and create accordingly, TODO
   * @param _randSq random sequence generated from _generateRandomSequence function
   * @param _beastType from client side, rarity of the beast wanted
   * @param _name from client side, name of the beast
   */
    function _resolveBeast(uint _randSq, Rarity _beastType, string memory _name) private {
        if(_beastType == Rarity.notRare)
            _notRarePowers(_randSq, _beastType, _name);
        // else if(_beastType == Rarity.rare)
        //     _rarePowers(_randSq, _beastType);
        // else if(_beastType == Rarity.superRare)
        //     _superRarePowers(_randSq, _beastType);
        // else if(_beastType == Rarity.utlraSuperRare)
        //     _utlraSuperRarePowers(_randSq, _beastType);
        // else
        //     _mythicalPowers(_randSq, _beastType);
    } 

    /**
   * @dev _generateRandomSequence function to create a random sequence.
   * @param _name from client side, create random sequence using name as param
   */
    function _generateRandomSequence(string memory _name) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_name)));
        return rand % powerModulus;
    }

    /**
   * @dev _notRarePowers generates the non rare beast
   * @param _randSq random sequence generated from _generateRandomSequence function
   * @param _beastType from client side, rarity of the beast wanted
   * @param _name from client side, name of the beast
   */
    function _notRarePowers(
        uint _randSq,
        Rarity _beastType,
        string memory _name
    ) 
        private view returns (uint) 
    {
        uint firstPair = 2;
        // extract powers of the beast
        uint pw1 = _getPowerNo(_randSq, firstPair);
        power memory notRare = powers[1][pw1]; // powers[1] -> refers to all powers that belong to categoty non rare
        powersOwned.push(notRare);
        // extract health of the beast
        uint health = _getHealth(_randSq);
        // create new beast
        uint id = beasts.push(beast(
            _name,
            _beastType,
            powersOwned,
            health)) - 1;  
        emit NewBeast(id, _name, _beastType, health);
    }

    /**
   * @dev createBeast responsible of creating a beast, calls a no. of internal functions.
   * @param _randSq random sequence generated from _generateRandomSequence function
   * @param _Pair which pair of numbers to be extracted from the _randPower
   */
    function _getPowerNo (uint _randSq, uint _Pair) private view returns (uint) {
        uint pw = _randSq / 10**(powerDigits-_Pair);
        return (pw / 10) + (pw % 10);        
    }

    /**
   * @dev createBeast responsible of creating a beast, calls a no. of internal functions.
   * @param _randSq random sequence generated from _generateRandomSequence function
   * @param _Pair which pair of numbers to be extracted from the _randPower
   */
    function _getHealth (uint _randSq) private view returns (uint) {
        uint hl = _randSq / 10**(2);
        return (hl / 10) + (hl % 10);        
    }
    
}