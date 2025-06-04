public fun distribute_rewards(
    vault: &mut StakeVault,
    pool: &mut RewardPool,
    winner_address: address,
    creator_address: address,
    ctx: &mut TxContext
) {
    assert!(clock::now_seconds() >= vault.voting_end_time, 100); // ensure voting is over

    let total_staked = vault.total_staked;
    let total_pool = balance::value(&pool.pool_balance);

    let creator_reward = total_pool / 10; // 10% to creator
    let voter_reward_pool = total_pool - creator_reward;

    // Mint creator's bonus
    let creator_coin = balance::split(&mut pool.pool_balance, creator_reward);
    transfer::transfer(coin::into_coin(creator_coin), creator_address);

    // Distribute voter rewards
    let keys = Table::keys(&vault.stakes);
    let vals = Table::values(&vault.stakes);

    let len = vector::length(&keys);
    let mut i = 0;

    while (i < len) {
        let voter = *vector::borrow(&keys, i);
        let stake_amount = *vector::borrow(&vals, i);

        if (voter == winner_address) {
            let share = stake_amount * voter_reward_pool / total_staked;
            let voter_coin = balance::split(&mut pool.pool_balance, share);
            transfer::transfer(coin::into_coin(voter_coin), voter);
        }

        i = i + 1;
    }

    assert!(balance::value(&pool.pool_balance) == 0, 101); // pool should be fully distributed
}
