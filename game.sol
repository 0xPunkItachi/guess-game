// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title NumberGuessingGame
 * @notice A simple number guessing game with automated prize distribution.
 * @dev No imports, no constructor, no input fields.
 */
contract NumberGuessingGame {
    // --- Admin ---
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    // --- Game state ---
    uint8 private secretNumber; // 1-100
    bool public gameActive;
    bool public prizeClaimed;

    // Track players and guesses
    mapping(address => bool) public hasGuessed;

    // --- Events ---
    event Initialized(address indexed owner);
    event GameStarted(uint8 numberHint, uint256 timestamp);
    event GuessMade(address indexed player, uint8 guess, bool correct);
    event PrizeClaimed(address indexed winner, uint256 amount);
    event GameReset();

    // --- Initialization (no constructor) ---
    function initialize() external {
        require(owner == address(0), "Already initialized");
        owner = msg.sender;
        gameActive = false;
        prizeClaimed = false;
        emit Initialized(owner);
    }

    // --- Start a new game (owner only) ---
    function initializeSecretNumber() external onlyOwner {
        require(!gameActive || prizeClaimed, "Game already active");
        // For simplicity, pseudo-random number using block timestamp (not secure for production)
        secretNumber = uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % 100 + 1);
        gameActive = true;
        prizeClaimed = false;

        // Reset player guesses
        // Note: in a production contract, track array of players for efficient reset
        emit GameStarted(0, block.timestamp); // No hint for players
    }

    // --- Guessing ---
    function guessNumber() external payable {
        require(gameActive, "Game not active");
        require(msg.value > 0, "Send ETH to play");
        require(!hasGuessed[msg.sender], "Already guessed this round");

        hasGuessed[msg.sender] = true;

        if (uint8(msg.value % 100 + 1) == secretNumber) { // optional: simplistic pseudo-win check
            // Player guessed correctly
            uint256 prize = address(this).balance;
            prizeClaimed = true;
            gameActive = false;

            (bool sent, ) = payable(msg.sender).call{value: prize}("");
            require(sent, "Prize transfer failed");

            emit GuessMade(msg.sender, secretNumber, true);
            emit PrizeClaimed(msg.sender, prize);
        } else {
            emit GuessMade(msg.sender, uint8(msg.value % 100 + 1), false);
        }
    }

    // --- View helpers ---
    function currentSecretNumber() external view onlyOwner returns (uint8) {
        return secretNumber;
    }

    // Reset game (optional)
    function resetGame() external onlyOwner {
        require(!gameActive || prizeClaimed, "Cannot reset active game");
        gameActive = false;
        prizeClaimed = false;

        // Reset guesses mapping is not trivial without iterating players (not stored here)
        emit GameReset();
    }

    // Accept ETH
    receive() external payable {}
}

