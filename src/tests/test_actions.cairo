use array::ArrayTrait;
use debug::PrintTrait;

use cubit::f64::{Fixed, FixedTrait, Vec2};
use duel::actions::shoot;
use duel::types::{Shot, ShotResult};

#[test]
#[available_gas(10000000)]
fn test_shoot_hit_target() {
    let shot = Shot { velocity: 20, angle: 1000 };
    let origin = Vec2 { x: FixedTrait::ZERO(), y: FixedTrait::ZERO() };
    // TODO: recheck the target position and the shot calc
    let target = Vec2 { x: FixedTrait::from_felt(0x2294501e70), y: FixedTrait::from_felt(0x3a07f57e7) };
    let top_right = Vec2 { x: FixedTrait::new_unscaled(1500, false), y: FixedTrait::new_unscaled(1500, false) };

    let (shot_result, _) = shoot(shot, origin, target, top_right);
    assert(shot_result == ShotResult::Hit, 'no hit');
}

#[test]
#[available_gas(10000000)]
fn test_shoot_miss_target() {
    let shot = Shot { velocity: 20, angle: 1000 };
    let origin = Vec2 { x: FixedTrait::ZERO(), y: FixedTrait::ZERO() };
    let target = Vec2 { x: FixedTrait::new_unscaled(350, false), y: FixedTrait::ZERO() };
    let top_right = Vec2 { x: FixedTrait::new_unscaled(1500, false), y: FixedTrait::new_unscaled(1500, false) };

    let (shot_result, _) = shoot(shot, origin, target, top_right);
    assert(shot_result == ShotResult::Miss, 'no miss');
}
