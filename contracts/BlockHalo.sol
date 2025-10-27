// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title BlockHalo
 * @dev A decentralized verification system where users submit data blocks and admin validates them.
 */
contract Project {
    address public admin;
    uint256 public blockCount;

    struct DataBlock {
        uint256 id;
        address submitter;
        string contentHash;
        bool verified;
        uint256 timestamp;
    }

    mapping(uint256 => DataBlock) public dataBlocks;

    event BlockSubmitted(uint256 indexed id, address indexed submitter, string contentHash);
    event BlockVerified(uint256 indexed id);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    // ✅ Function 1: Submit a data block
    function submitBlock(string memory _contentHash) public {
        require(bytes(_contentHash).length > 0, "Content hash cannot be empty");

        blockCount++;
        dataBlocks[blockCount] = DataBlock(
            blockCount,
            msg.sender,
            _contentHash,
            false,
            block.timestamp
        );

        emit BlockSubmitted(blockCount, msg.sender, _contentHash);
    }

    // ✅ Function 2: Verify a data block (admin only)
    function verifyBlock(uint256 _id) public onlyAdmin {
        DataBlock storage db = dataBlocks[_id];
        require(!db.verified, "Block already verified");
        db.verified = true;

        emit BlockVerified(_id);
    }

    // ✅ Function 3: View data block details
    function getBlock(uint256 _id) public view returns (DataBlock memory) {
        require(_id > 0 && _id <= blockCount, "Invalid block ID");
        return dataBlocks[_id];
    }
}
