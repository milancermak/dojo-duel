#[system]
mod init_duel {
    use starknet::contract_address::ContractAddressZeroable;
    use traits::Into;

    use dojo::world::Context;
    use duel::components::{Duel};

    fn execute(ctx: Context) {
        // generate world via noise? or maybe just randomness?
        // I guess we only need rnd to get the building heights and the position of players
        // so maybe noise is an overkill, just use prng / hashing - sig_r?

        // init duel
        let duel_id = ctx.world.uuid();
        let player1 = ctx.origin;
        set!(ctx.world, ( Duel {
            id: duel_id,
            player1,
            player2: ContractAddressZeroable::zero(),
            next_turn: 1,
            winner: 0
        }));

        // spawn player1
        // set!(ctx.world, (duel_id, player1).into(), ( Point { x: 10, y: 30 } )); // TODO: coords
        // TODO: need player position
        //       prob should be assigned to both players at duel creation time

        // TODO: emit duel_id
    }
}

#[system]
mod join_duel {
    use traits::Into;
    use zeroable::Zeroable;

    use dojo::world::Context;
    use duel::components::Duel;

    fn execute(ctx: Context, duel_id: usize) {
        // check if duel exists
        let mut duel = get!(ctx.world, duel_id, Duel);
        assert(duel.player1.is_non_zero() && duel.winner == 0, 'duel does not exist');

        // if it does exist, attach player2
        duel.player2 = ctx.origin; // TODO: set a different point, half away from player1
        set!(ctx.world, (duel, ));

        // TODO: emit some kind of event?
    }
}

#[system]
mod fire {
    use traits::Into;
    use zeroable::Zeroable;

    use cubit::f64::{Fixed, Vec2, Vec2Trait};

    use dojo::world::Context;
    use duel::components::Duel;
    use duel::types::Shot;

    fn execute(ctx: Context, duel_id: usize, shot: Shot) {
        let mut duel = get!(ctx.world, duel_id, Duel);

        // check if duel exists
        assert(duel.player1.is_non_zero(), 'duel does not exist');

        // check if the duel is not over yet
        assert(duel.winner == 0, 'duel is over');

        // check if player is in the duel and it's their turn
        let next_player = if (duel.next_turn == 1) { duel.player1 } else { duel.player2 };
        assert(ctx.origin == next_player, 'not your turn');

        // fire a projectile, somehow...
        // TODO: port all the necessary checks from projectile.cairo




        // check if direct hit, if so, end the duel, otherwise update

        // update duel
        duel.next_turn = 3 - duel.next_turn;
        set!(ctx.world, (duel, ));
    }
}

// TODO: system to end game / give up?
