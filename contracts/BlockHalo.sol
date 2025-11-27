// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BlockHalo {
    struct Halo {
        address user;
        uint256 timestamp;
        string badge; // Name or type of achievement
    }

    // Mapping from halo ID to Halo details
    mapping(uint256 => Halo) private halos;
    uint256 private nextHaloId = 1;

    // Event emitted when a new halo is awarded
    event HaloAwarded(uint256 indexed haloId, address indexed user, uint256 timestamp, string badge);

    // Award a new halo (badge) to a user
    function awardHalo(address user, string memory badge) external {
        require(user != address(0), "Invalid address");

        halos[nextHaloId] = Halo({
            user: user,
            timestamp: block.timestamp,
            badge: badge
        });

        emit HaloAwarded(nextHaloId, user, block.timestamp, badge);
        nextHaloId++;
    }

    // View a halo by ID
    function viewHalo(uint256 haloId) external view returns (address user, uint256 timestamp, string memory badge) {
        Halo memory h = halos[haloId];
        require(h.timestamp != 0, "Halo does not exist");
        return (h.user, h.timestamp, h.badge);
    }

    // Get total number of halos awarded
    function totalHalos() external view returns (uint256) {
        return nextHaloId - 1;
    }
}
