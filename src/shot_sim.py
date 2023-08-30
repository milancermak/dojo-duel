from collections import namedtuple
from math import cos, sin, sqrt

Shot = namedtuple("Shot", ["velocity", "angle"])
Vec2 = namedtuple("Vec2", ["x", "y"])

def shoot(shot: Shot, origin: Vec2, target: Vec2, top_right: Vec2):

    v0 = Vec2(shot.velocity * cos(shot.angle), shot.velocity * sin(shot.angle))

    g = 9.8
    delta_t = 0.1
    collision_radius = 10
    n = 0
    path = []

    while True:
        t = n * delta_t
        x = origin.x + v0.x * t
        y = origin.y + v0.y * t - 0.5 * g * t**2
        print(f"({x}, {y})")
        path.append(Vec2(x, y))

        if x < 0 or y < 0 or x > top_right.x:
            print("Out of bounds")
            print(n)
            break

        distance = sqrt((target.x - x)**2 + (target.y - y)**2)
        if distance <= collision_radius:
            print("Hit!")
            print(n)
            break

        n += 1

def main():
    shot = Shot(20, 1)
    origin = Vec2(0, 0)
    target = Vec2(350, 0)
    top_right = Vec2(1500, 1500)

    shoot(shot, origin, target, top_right)

if __name__ == "__main__":
    main()
