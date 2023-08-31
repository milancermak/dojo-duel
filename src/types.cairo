#[derive(Copy, Drop, Serde)]
struct Shot {
    // TODO: doc what scale, etc.
    velocity: u64,
    // in rad, scaled by 1000
    angle: u64
}

// TODO: should there be an "impact" variant?
#[derive(Drop, PartialEq)]
enum ShotResult {
    Hit,
    Miss,
}
