import aoc_2025.{InvalidDirection, InvalidDistance, parse_line, rotate}
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  let name = "Joe"
  let greeting = "Hello, " <> name <> "!"

  assert greeting == "Hello, Joe!"
}

pub fn parse_line_test() {
  assert parse_line("L65") == Ok(-65)
  assert parse_line("R48") == Ok(48)
  assert parse_line("r65") == Error(InvalidDirection)
  assert parse_line("Ljk") == Error(InvalidDistance)
}

pub fn rotate_test() {
  assert rotate(50, -68, 0) == 1
  assert rotate(50, 68, 0) == 1
  assert rotate(50, 30, 0) == 0
  assert rotate(1, -301, 0) == 4
  assert rotate(50, -1000, 0) == 10
  assert rotate(50, 1000, 0) == 10
  assert rotate(0, -500, 0) == 5
  assert rotate(5, -10, 0) == 1
  assert rotate(5, -3, 0) == 0
  assert rotate(50, -51, 0) == 1
  assert rotate(50, -50, 0) == 1
  assert rotate(50, 50, 0) == 1
  assert rotate(50, 49, 0) == 0
  assert rotate(50, -49, 0) == 0
  assert rotate(50, 150, 0) == 2
}
