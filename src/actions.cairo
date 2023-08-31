use array::{ArrayTrait};

use cubit::f64::{Fixed, FixedTrait, Vec2};
use cubit::f64::math::trig;
use duel::types::{Shot, ShotResult};
use duel::utils::point_distance;

use debug::PrintTrait;

fn shoot(shot: Shot, origin: Vec2, target: Vec2, top_right: Vec2) -> (ShotResult, Span<Vec2>) {
    let v = FixedTrait::new_unscaled(shot.velocity, false);
    // launch angle, in rad
    let theta0 = FixedTrait::new_unscaled(shot.angle, false) / FixedTrait::new_unscaled(1000, false);

    // launch velocity vector
    let v0 = Vec2 {
        x: v * trig::cos(theta0),
        y: v * trig::sin(theta0),
    };

    // gravitational acceleration
    // TODO: make it a const?
    let g = FixedTrait::new_unscaled(981, false) / FixedTrait::new_unscaled(100, false); // 9.8
    let ONE = FixedTrait::ONE();
    let HALF = FixedTrait::new(cubit::f64::types::fixed::HALF, false);

    // tunable params
    let delta_t = FixedTrait::new_unscaled(1, false) / FixedTrait::new_unscaled(10, false); // TODO: tune this param
    let collision_radius = FixedTrait::new_unscaled(10, false);

    let mut n = FixedTrait::ZERO();
    let mut path: Array<Vec2> = Default::default();

    let shot_result = loop {
        // calculate the next position of a projectile
        let t = n * delta_t;
        let x = origin.x + v0.x * t;
        let y = origin.y + v0.y * t - HALF * g * t * t;
        let p = Vec2 { x, y };
        path.append(p);

        // TODO: do some collision detection with the buildings
        // once that's set up

        // if y is negative, projectile impacted the ground
        if y.sign {
            'miss'.print();
            break ShotResult::Miss;
        }

        // scene origin is bottom left, (0, 0), so if x
        // if negative or if its value is greater than
        // the right border of the scene, the projectile
        // is out of bounds
        if x.sign || x.mag > top_right.x.mag {
            'out of bounds'.print();
            break ShotResult::Miss;
        }

        // check for projectile collision with target
        let distance: Fixed = point_distance(@p, @target);
        if distance <= collision_radius {
            'hit'.print();
            break ShotResult::Hit;
        }

        n += ONE;
    };

    (shot_result, path.span())
}
