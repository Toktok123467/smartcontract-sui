TOKTOK

# 🎵 Toktok Stake-to-Vote Smart Contract (Sui Move)

**Toktok** is a memecoin-powered, AI music remix platform where users stake `$TOKTOK` tokens to vote for their favorite AI-generated battle tracks. This repository contains a Move-based smart contract for the **Sui blockchain** that enables a **stake-to-vote mechanism**.

---

## 🚀 Features

- Stake `$TOKTOK` tokens to vote in an AI-generated music battle.
- Each token staked counts as one vote.
- Battle creators can initiate and end voting rounds.
- Votes are tallied and stored on-chain.
- Tokens are locked during voting for fairness (burned in this version for simplicity).

---

## 📦 Smart Contract Details

- **Module Address:** `0xe0bbe0028343df0aba72f60e8bfb00f6209a6de3cd7098dcad689089684afc0e`
- **Module Name:** `stake_vote_toktok`
- **Language:** [Move](https://github.com/move-language/move)
- **Chain:** [Sui Testnet](https://docs.sui.io/)
- **Coin Type:** `TOKTOK` (Custom `Coin<TOKTOK>`)

---

## 📁 Project Structure



## Project Structure

- **frontend**: Contains a React JS application built using Vite.
- **contracts**: Contains the Move language smart contracts.

---

## Prerequisites

1. **SUI CLI Setup:**  
   - Follow the official SUI documentation to install the CLI and create an account: [SUI Setup Instructions](https://docs.sui.io/guides/developer/getting-started/sui-install)

2. **Node.js & pnpm:**  
   Ensure you have Node.js installed. Then install pnpm globally:

   ```bash
   npm install -g pnpm
   ```

---

## Step-by-Step Setup

1. Navigate to the `frontend` folder:

   ```bash
   cd frontend
   ```

2. Install the dependencies:

   ```bash
   pnpm install
   ```

3. Start the development server:

   ```bash
   pnpm dev
   ```

---

## Additional Resources

- Official SUI Documentation: [https://docs.sui.io](https://docs.sui.io)
- Course Link: [https://academy.eincode.com/courses/sui-dapps-with-move-react-build-real-projects](https://academy.eincode.com/courses/sui-dapps-with-move-react-build-real-projects)

Happy coding! 🚀
