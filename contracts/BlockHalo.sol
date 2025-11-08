// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title BlockHalo
 * @notice A decentralized reputation and trust protocol that allows users 
 *         to endorse each other on-chain, forming a transparent "halo" of trust.
 */
contract Project {
    address public admin;
    uint256 public endorsementCount;

    struct Endorsement {
        uint256 id;
        address endorser;
        address endorsedUser;
        string message;
        uint256 timestamp;
    }

    mapping(uint256 => Endorsement) public endorsements;
    mapping(address => uint256) public reputation;

    event Endorsed(address indexed from, address indexed to, string message, uint256 id);
    event ReputationReset(address indexed user);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    /**
     * @notice Endorse another user with a message.
     * @param _to Address of the user being endorsed.
     * @param _message A short endorsement message.
     */
    function endorse(address _to, string memory _message) external {
        require(_to != msg.sender, "Cannot endorse yourself");
        require(bytes(_message).length > 0, "Message cannot be empty");

        endorsementCount++;
        endorsements[endorsementCount] = Endorsement(
            endorsementCount,
            msg.sender,
            _to,
            _message,
            block.timestamp
        );

        reputation[_to] += 1;
        emit Endorsed(msg.sender, _to, _message, endorsementCount);
    }

    /**
     * @notice View a specific endorsement by ID.
     * @param _id The ID of the endorsement.
     * @return Endorsement details.
     */
    function getEndorsement(uint256 _id) external view returns (Endorsement memory) {
        require(_id > 0 && _id <= endorsementCount, "Invalid endorsement ID");
        return endorsements[_id];
    }

    /**
     * @notice Reset a user's reputation (Admin only).
     * @param _user Address of the user to reset reputation.
     */
    function resetReputation(address _user) external onlyAdmin {
        reputation[_user] = 0;
        emit ReputationReset(_user);
    }
}
// 
End
// 
