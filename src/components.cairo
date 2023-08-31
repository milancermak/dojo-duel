use starknet::ContractAddress;

use cubit::f64::Vec2;

impl Vec2SerdeLen of dojo::serde::SerdeLen<Vec2> {
    fn len() -> usize {
        2
    }
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Duel {
    #[key]
    id: usize,
    player1: ContractAddress,
    player2: ContractAddress,
    next_turn: u8, // TODO: use an enum
    winner: u8, // 0 is unfinished, 1 is player1, 2 is player2; TODO: enum
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Position {
    #[key]
    duel_id: usize,
    #[key]
    player: ContractAddress,
    coords: Vec2
}
