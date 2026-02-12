use core::circuit::u384;
use starkcash::ghost_pool::{G1Point, G2Point};

pub fn get_ic() -> Span<G1Point> {
    let mut ic: Array<G1Point> = array![
        G1Point { x: 0, y: 0 },
    ];
    ic.span()
}
