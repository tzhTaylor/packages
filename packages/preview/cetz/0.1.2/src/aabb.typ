#import "vector.typ"

/// Compute an axis aligned bounding box (aabb)
/// for a list of vectors.
///
/// An aabb dictionary has the following keys:
///  - low  (vector) Min. bounds vector
///  - high (vector) Max. bounds vector
///
/// - pts (array): List of vectors/points
/// - init (dictionary): Initial aabb
/// -> dictionary AABB object
#let aabb(pts, init: none) = {
  let bounds = init

  if type(pts) == array {
    for (i, pt) in pts.enumerate() {
      if bounds == none and i == 0 {
        bounds = (low: pt, high: pt)
      } else {
        let (x, y, z) = pt

        let (lo-x, lo-y, lo-z) = bounds.low
        bounds.low = (calc.min(lo-x, x), calc.min(lo-y, y), calc.min(lo-z, z))

        let (hi-x, hi-y, hi-z) = bounds.high
        bounds.high = (calc.max(hi-x, x), calc.max(hi-y, y), calc.max(hi-z, z))
      }
    }
    return bounds
  } else if type(pts) == dictionary {
    if init == none {
      return pts
    } else {
      return aabb((pts.low, pts.high,), init: bounds)
    }
  }

  panic("Expected array of vectors or bbox dictionary, got: " + repr(pts))
}

/// Get the mid-point of an aabb as vector.
///
/// - bounds (AABB): AABB
/// -> vector
#let mid(bounds) = {
  return vector.scale(vector.add(bounds.low, bounds.high), .5)
}

/// Get the size of an aabb as vector
/// this is a vector from the aabb's low to high.
///
/// - bounds (AABB): AABB
/// -> vector
#let size(bounds) = {
  return vector.sub(bounds.high, bounds.low)
}