#[derive(Copy, Drop, Serde)]
struct Shot {
    // TODO: doc what scale, etc.
    velocity: u64,
    // in radians
    // TODO: reconsider if in radians, or how to encode that for the calculations
    angle: u64
}

// TODO: should there be an "impact" variant?
#[derive(Drop)]
enum ShotResult {
    Hit,
    Miss,
}
