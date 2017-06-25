pragma solidity ^0.4.2;

// Main Fingerprint Contract
contract Fingerprint {

  // Contract owner
  address public owner;

  // Number of ownership records
  uint public recordCount = 0;

  // Mapping for hash access
  // Owner address -> File hashes
  mapping (address => string[]) hashes;

  // Mapping for record access
  // Owner address -> File hash -> Ownership record
  mapping (address => mapping(string => Ownership)) records;

  // Constructor
  function Fingerprint() {

    // Set the owner of the contract
    owner = msg.sender;
  }

  // Change the owner of the contract
  function changeOwner (address newOwner) {

    // Change the owner address if the sender is the current owner
    if (owner == msg.sender){ owner = newOwner; }
  }

  // Attempt to create a new ownership record
  function newRecord (string fileHash, string name, string author, string filename, string description) {

    // Check the hash is of the correct length
    if (bytes(fileHash).length == 64) {

      // Add the hash record
      hashes[msg.sender].push(fileHash);

      // Add the ownership record
      records[msg.sender][fileHash] = Ownership(name, author, filename, description, now);

      // Increment the record count
      recordCount++;
    }
  }

  // Get a filehash belonging to an address
  function getFileHash (address owner, uint index) constant returns (string) {
    return hashes[owner][index];
  }

  // Get an ownership record name
  function getRecordName (address owner, string fileHash) constant returns (string) {
    return records[owner][fileHash].name;
  }

  // Get an ownership record author
  function getRecordAuthor (address owner, string fileHash) constant returns (string) {
    return records[owner][fileHash].author;
  }

  // Get an ownership record filename
  function getRecordFilename (address owner, string fileHash) constant returns (string) {
    return records[owner][fileHash].filename;
  }

  // Get an ownership record description
  function getRecordDescription (address owner, string fileHash) constant returns (string) {
    return records[owner][fileHash].description;
  }

  // Get an ownership record timestamp
  function getRecordTimestamp (address owner, string fileHash) constant returns (uint) {
    return records[owner][fileHash].timestamp;
  }

  // Ownership record object
  struct Ownership {
        string name;
        string author;
        string filename;
        string description;
        uint timestamp;
    }
}