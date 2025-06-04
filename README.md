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

- **Module Address:** `0xf35829f4289a88a98f05391c08df74d258e1a52869d5ee9e29596e50592475d1`
- **Module Name:** `stake_vote_toktok`
- Decimals: 8
- publisher: 0x9c19049d269c7e153b458d9b9ac9f2c5209243836967ab16fc3b2e01f7ba0dc1
- https://suiscan.xyz/devnet/object/0xf35829f4289a88a98f05391c08df74d258e1a52869d5ee9e29596e50592475d1/tx-blocks
Total Supply: 1,000,000,000 Tkt
Utility:
Used for staking to vote in community decisions (e.g., voice NFT battles, remix contests).
Distributed as rewards for active content creation and community engagement.
Enables on-chain governance and creator-led decisions.
- **Language:** [Move](https://github.com/move-language/move)
- **Chain:** [Sui Testnet](https://docs.sui.io/)
- **Coin Type:** `TOKTOK` (Custom `Coin<TOKTOK>`)
-  Smart Contract Purpose
The purpose of the stake_vote_toktok module is to:
Allow users to stake TokTok Tokens (TKT) to gain voting power in community proposals or rap battles.
Support creator competition-based governance (e.g., voting on winning AI-voice remix battles).
Enable reward distribution based on staked participation.
 How It Works
Staking:
Users stake TKT tokens to support a creator or battle participant.
Staked tokens are locked until the voting period ends.
Voting:
Voting power = Amount of tokens staked.
Users vote by staking on a creator’s profile or proposal ID.
Unstaking:
After the vote ends, users can unstake their TKT tokens.
Reward Distribution:
Rewards can be distributed to users who staked on the winning creator.
Creators can also receive bonus TKT based on votes earned.


Data Structures
struct RewardPool has key {
    id: UID,
    pool_balance: Balance<TokTokToken>,
}



 Updated Functions
public fun create_reward_pool(
    ctx: &mut TxContext
): RewardPool {
    let id = object::new(ctx);
    let pool_balance = balance::zero<TokTokToken>();
    RewardPool { id, pool_balance }
}


2. Fund the Reward Pool
public fun fund_pool(
    pool: &mut RewardPool,
    coins: Coin<TokTokToken>
) {
    balance::join(&mut pool.pool_balance, coin::into_balance(coins));
}
---

## 📁 Project Structure
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
