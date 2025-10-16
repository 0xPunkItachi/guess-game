# guess-game

# 🎲 Number Guessing Game (Flow Blockchain)

A decentralized **number guessing game** where participants compete to guess a secret number and win the prize pool.  
The first correct guess automatically receives the contract’s ETH balance as a reward.

> 🌐 **Deployed on Flow Blockchain (Testnet)**  
> **Contract Address:** `0xc7b3eAfFe14011276BcC8f27e5416d28651f1a82`

---

## 🧩 Overview

This smart contract allows players to **participate in a number guessing game** on-chain.  
Key characteristics:
- Owner sets a secret number each round.
- Players submit guesses by sending ETH.
- First correct guess automatically receives all funds in the contract.
- Single active round at a time.
- Fully self-contained Solidity contract (no imports, no constructors, no input fields).

---

## ✨ Key Features

✅ **Automated Prize Distribution**  
The first correct guess automatically receives the total contract balance.

✅ **Owner-Controlled Secret Number**  
Owner initializes the secret number for each round.

✅ **Single Active Round**  
Ensures that only one game is active at a time.

✅ **Simple Gameplay**  
Players submit guesses via ETH transactions with `guessNumber()`.

✅ **Transparent Events**  
All actions are logged: game start, guesses, and prize claims.

---

## 🛠️ Technical Specifications

| Parameter | Description |
|-----------|-------------|
| **Blockchain** | Flow Blockchain (Testnet) |
| **Contract Address** | `0xc7b3eAfFe14011276BcC8f27e5416d28651f1a82` |
| **Secret Number Range** | 1 - 100 |
| **Prize Distribution** | Full contract balance to first correct guess |
| **Security Level** | Educational / Testnet only |

---

## ⚙️ Smart Contract Functions

### 🏁 Initialization
| Function | Description |
|-----------|-------------|
| `initialize()` | Sets the contract owner. Must be called once after deployment. |

---

### 🎮 Game Management
| Function | Description |
|-----------|-------------|
| `initializeSecretNumber()` | Owner starts a new round and sets a pseudo-random secret number. |
| `resetGame()` | Owner can reset the game after completion or prize claim. |

---

### 🕹️ Gameplay
| Function | Description |
|-----------|-------------|
| `guessNumber()` | Player submits a guess (send ETH). If correct, wins the prize pool. |

---

### 🔍 View Helpers
| Function | Description |
|-----------|-------------|
| `currentSecretNumber()` | Returns the secret number (owner only). |
| `gameActive` | Checks if a round is currently active. |
| `prizeClaimed` | Checks if the prize has been claimed. |

---

## 🧠 How It Works

1. **Initialize Contract**
   ```solidity
   initialize()
