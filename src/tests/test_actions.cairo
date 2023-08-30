use array::ArrayTrait;
use debug::PrintTrait;

use cubit::f64::{Fixed, FixedTrait, Vec2};
use duel::actions::shoot;
use duel::types::Shot;

#[test]
#[available_gas(1000000000)]
fn test_shoot_hit_target() {
    let shot = Shot { velocity: 20, angle: 1 };
    let origin = Vec2 { x: FixedTrait::ZERO(), y: FixedTrait::ZERO() };
    let target = Vec2 { x: FixedTrait::new_unscaled(350, false), y: FixedTrait::ZERO() };
    let top_right = Vec2 { x: FixedTrait::new_unscaled(1500, false), y: FixedTrait::new_unscaled(1500, false) };

    shoot(shot, origin, target, top_right);
}

#[test]
#[available_gas(10000000)]
fn test_shoot_miss_target() {

}

#[test]
#[available_gas(10000000)]
fn test_shoot_out_of_bounds() {

}
