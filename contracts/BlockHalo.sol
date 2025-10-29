? Function 1: Submit a data block
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

    ? Function 3: View data block details
    function getBlock(uint256 _id) public view returns (DataBlock memory) {
        require(_id > 0 && _id <= blockCount, "Invalid block ID");
        return dataBlocks[_id];
    }
}
// 
update
// 
