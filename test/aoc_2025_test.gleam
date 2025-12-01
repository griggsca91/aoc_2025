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
}
