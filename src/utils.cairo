use cubit::f64::{Fixed, FixedTrait, Vec2};

fn point_distance(p1: @Vec2, p2: @Vec2) -> Fixed {
    let dx: Fixed = *p2.x - *p1.x;
    let dy: Fixed = *p2.y - *p1.y;
    (dx * dx + dy * dy).sqrt()
}
