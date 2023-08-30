#[system]
mod init_duel {
    use starknet::contract_address::ContractAddressZeroable;
    use traits::Into;

    use cubit::f64::{Fixed, FixedTrait, Vec2, Vec2Trait};
    use dojo::world::Context;

    use duel::components::{Duel, Position};

    fn execute(ctx: Context) {
        // generate world via noise? or maybe just randomness?
        // I guess we only need rnd to get the building heights and the position of players
        // so maybe noise is an overkill, just use prng / hashing - sig_r?

        // init duel
        let duel_id = ctx.world.uuid();
        set!(ctx.world, ( Duel {
            id: duel_id,
            player1: ctx.origin,
            player2: ContractAddressZeroable::zero(),
            next_turn: 1,
            winner: 0
        }));

        // spawn player1
        let coords = Vec2 {
            x: FixedTrait::new_unscaled(10, false),
            y: FixedTrait::ZERO()
        }; // TODO: proper random coords

        set!(ctx.world, ( Position {
            duel_id,
            player: ctx.origin,
            coords
        }));

        // TODO: emit duel_id & p1 position
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
        let mut duel: Duel = get!(ctx.world, duel_id, Duel);
        assert(duel.player1.is_non_zero() && duel.winner.is_zero(), 'duel does not exist');

        // if duel exists, spawn player2
        let player2 = ctx.origin;
        let coords = Vec2 {
            x: FixedTrait::new_unscaled(700, false),
            y: FixedTrait::ZERO()
        };// TODO: proper random coords

        set!(ctx.world, ( Position {
            duel_id,
            player: player2,
            coords
        }));

        // attach player2 to the duel
        duel.player2 = ctx.origin;
        set!(ctx.world, (duel, ));

        // TODO: emit player2 position
    }
}

#[system]
mod fire {
    use traits::Into;
    use zeroable::Zeroable;

    use cubit::f64::{Fixed, FixedTrait, Vec2, Vec2Trait};

    use dojo::world::Context;
    use duel::actions::shoot;
    use duel::components::{Duel, Position};
    use duel::types::{Shot, ShotResult};

    fn execute(ctx: Context, duel_id: usize, shot: Shot) {
        let mut duel: Duel = get!(ctx.world, duel_id, Duel);

        // check if duel exists
        assert(duel.player1.is_non_zero(), 'duel does not exist');

        // check if the duel is not over yet
        assert(duel.winner == 0, 'duel is over');

        // check if player is in the duel and it's their turn
        let next_player = if (duel.next_turn == 1) { duel.player1 } else { duel.player2 };
        assert(ctx.origin == next_player, 'not your turn');

        let p1_pos: Position = get!(ctx.world, (duel_id, duel.player1), Position);
        let p2_pos: Position = get!(ctx.world, (duel_id, duel.player2), Position);

        let (origin, target) = if (duel.next_turn == 1) {
            // player1 is shooting
            (p1_pos.coords, p2_pos.coords)
        } else {
            // player2 is shooting
            (p2_pos.coords, p1_pos.coords)
        };

        // TODO: const this
        let top_right = Vec2 {
            x: FixedTrait::new_unscaled(1000, false),
            y: FixedTrait::new_unscaled(1000, false)
        };

        // TODO: port all the necessary checks from projectile.cairo

        // fire a projectile
        let (shot_result, projectile_path) = shoot(shot, origin, target, top_right);

        // TODO: emit projectile path so it can be mapped

        match shot_result {
            ShotResult::Hit => {
                // set the duel winner, the duel is implicitly over
                duel.winner = duel.next_turn;
            },
            ShotResult::Miss => {
                // set the turn to next player
                duel.next_turn = 3 - duel.next_turn;
            },
        }

        set!(ctx.world, (duel, ));

        // TODO: emit something else?
    }
}

// TODO: system to end game / give up?
