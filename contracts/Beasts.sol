pragma solidity >=0.4.22 <0.6.0;

/**
 * @title Beasts
 * @dev a contract holding all the functionality and logic for beast
 */
 
contract Beasts {

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
}