module 0xf35829f4289a88a98f05391c08df74d258e1a52869d5ee9e29596e50592475d1::stake_vote_toktok {

    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use sui::balance::{Self, Balance};
    use sui::coin::{Self, Coin};
    use sui::table::{Self, Table};
    use sui::option::{Self, Option};
    use sui::vector;
    use sui::event;
    use sui::string;
    use sui::error;

    struct TokTokToken has store, key {}

    struct StakeVault has key {
        id: UID,
        stakes: Table<address, u64>, // address => amount
        total_staked: u64,
        voting_end_time: u64,
        proposal_id: u64
    }

    public fun init_stake_vault(ctx: &mut TxContext, voting_end_time: u64, proposal_id: u64): StakeVault {
        let id = object::new(ctx);
        let stakes = Table::new(ctx);
        StakeVault {
            id,
            stakes,
            total_staked: 0,
            voting_end_time,
            proposal_id
        }
    }

    public fun stake(
        vault: &mut StakeVault,
        user: address,
        amount: u64,
        mut coins: Coin<TokTokToken>,
        ctx: &mut TxContext
    ) {
        assert!(clock::now_seconds() < vault.voting_end_time, 1); // voting is still active
        let existing = Table::get(&vault.stakes, &user).unwrap_or(0);
        Table::insert(&mut vault.stakes, user, existing + amount);
        vault.total_staked = vault.total_staked + amount;
        coin::burn(&mut coins, amount, ctx); // burn staked tokens for locking
    }

    public fun unstake(
        vault: &mut StakeVault,
        user: address,
        ctx: &mut TxContext
    ): Coin<TokTokToken> {
        assert!(clock::now_seconds() >= vault.voting_end_time, 2); // only after voting ends
        let amount = Table::remove(&mut vault.stakes, &user);
        vault.total_staked = vault.total_staked - amount;
        coin::mint<TokTokToken>(amount, ctx)
    }

    public fun get_stake(vault: &StakeVault, user: address): u64 {
        Table::get(&vault.stakes, &user).unwrap_or(0)
    }

    public fun get_total_staked(vault: &StakeVault): u64 {
        vault.total_staked
    }

    public fun voting_has_ended(vault: &StakeVault): bool {
        clock::now_seconds() >= vault.voting_end_time
    }

    // Token metadata & registration (only needs to be done once)
    public fun register_token(ctx: &mut TxContext): TokTokToken {
        TokTokToken {}
    }

    public fun mint_token(amount: u64, ctx: &mut TxContext): Coin<TokTokToken> {
        coin::mint<TokTokToken>(amount, ctx)
    }
}
