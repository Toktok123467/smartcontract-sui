module 0xe0bbe0028343df0aba72f60e8bfb00f6209a6de3cd7098dcad689089684afc0e::stake_vote_toktok {

    use std::error;
    use std::signer;
    use sui::object::UID;
    use sui::tx_context::{Self, TxContext};
    use sui::coin::{Self, Coin};
    use sui::balance;
    use sui::vector;

    /// The TOKTOK coin type.
    struct TOKTOK has key, store {}

    /// Represents a music battle
    struct Battle has key, store {
        id: u64,
        votes: vector<u64>,
        ended: bool,
        voters: vector<address>,
        total_stake: u64,
        uid: UID,
    }

    /// Represents a user's stake for a battle
    struct Stake has key, store {
        battle_id: u64,
        amount: u64,
        has_voted: bool,
        owner: address,
        uid: UID,
    }

    /// Counter for unique battle IDs
    struct BattleCounter has key, store {
        count: u64,
        uid: UID,
    }

    public fun init_counter(ctx: &mut TxContext): BattleCounter {
        BattleCounter {
            count: 0,
            uid: object::new(ctx),
        }
    }

    public fun create_battle(
        counter: &mut BattleCounter,
        ctx: &mut TxContext
    ): Battle {
        let id = counter.count;
        counter.count = counter.count + 1;
        Battle {
            id,
            votes: vector::empty<u64>(),
            ended: false,
            voters: vector::empty<address>(),
            total_stake: 0,
            uid: object::new(ctx),
        }
    }

    public fun stake_and_vote(
        user: &signer,
        battle: &mut Battle,
        mut coin: Coin<TOKTOK>,
        vote_index: u64,
        ctx: &mut TxContext
    ): Stake {
        assert!(!battle.ended, error::invalid_argument(0));

        let amount = coin::value(&coin);
        let voter_address = signer::address_of(user);
        battle.total_stake = battle.total_stake + amount;
        vector::push_back(&mut battle.voters, voter_address);

        // Initialize vote array if needed
        while (vector::length(&battle.votes) <= vote_index) {
            vector::push_back(&mut battle.votes, 0);
        }
        *vector::borrow_mut(&mut battle.votes, vote_index) += amount;

        let stake = Stake {
            battle_id: battle.id,
            amount,
            has_voted: true,
            owner: voter_address,
            uid: object::new(ctx),
        };

        coin::burn(coin); // Lock the coin (burn here for simplicity)

        stake
    }

    public fun end_battle(
        admin: &signer,
        battle: &mut Battle
    ) {
        battle.ended = true;
    }

    // Optional: reward winner, refund stakers, or redistribute
}
