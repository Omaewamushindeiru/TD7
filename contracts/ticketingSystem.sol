pragma solidity >= 0.4.24; 

contract ticketingSystem 
{ 
    address owner;
    uint artistCount;
    uint venueCount;

    event createdAnObject(uint objectNumber);

    struct Artist
    {
        bytes32 name;
        uint artistCategory;
        uint totalSoldTickets;

        address owner;

        uint artistID;
    }

    struct Venue
    {
        bytes32 name;
        uint capacity;
        uint standardComission;

        address owner;

        uint Venueid;
    }

    struct Concert
    {
        uint concertDate;

        uint artistId;


        bool validatedByArtist;
        bool validatedByVenue;
    }

    //struct Ticket
    //{
        

    //}

    mapping (uint => Artist) public artistsRegister;
    mapping (uint => Venue) public venuesRegister;
    //mapping (uint => Ticket) public;

    modifier onlyArtistOwner(uint _artistId) {
        require(artistsRegister[_artistId].owner == msg.sender);
        _;
    }

    modifier onlyVenueOwner(uint _artistId) {
        require(venuesRegister[_artistId].owner == msg.sender);
        _;
    }

    constructor() public {
        artistCount = 0;
        owner = msg.sender;
    }

    function createArtist(bytes32 _name, uint _category) public 
    {
        artistCount++;
        artistsRegister[artistCount] = Artist(_name, _category, 0, msg.sender, artistCount);
        emit createdAnObject(artistCount);
    }

    function modifyArtist(uint _id, bytes32 _name, uint _category, address _newOwner) public onlyArtistOwner(_id)
    {
        artistsRegister[_id].name = _name;
        artistsRegister[_id].artistCategory = _category;
        artistsRegister[_id].owner = _newOwner;
    }

    function createVenue(bytes32 _name, uint _capacity, uint _comission) public 
    {
        require(_comission >= 0 && _comission <= 10000);
        venueCount++;
        venuesRegister[venueCount] = Venue(_name, _capacity, _comission, msg.sender, venueCount);
        emit createdAnObject(venueCount);
    }

    function modifyVenue(uint _id, bytes32 _name, uint _capacity, uint _comission, address _newOwner) public onlyVenueOwner(_id)
    {
        venuesRegister[_id].name = _name;
        venuesRegister[_id].capacity = _capacity;
        venuesRegister[_id].owner = _newOwner;
        venuesRegister[_id].standardComission = _comission;
    }

    
}
