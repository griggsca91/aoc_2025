import gleam/int
import gleam/list
import gleam/pair
import gleam/result
import gleam/string
import simplifile

pub fn day1_part1(content: String) {
  content
  |> string.split(on: "\n")
  |> list.map(parse_line)
  |> result.values
  |> list.map_fold(from: 50, with: fn(acc, a) {
    let assert Ok(position) = int.modulo(acc + a, 100)
    #(position, position)
  })
  |> pair.second
  |> list.count(where: fn(a) { a == 0 })
  |> echo
}

type Sign {
  Positive
  Negative
  Zero
}

fn sign(a: Int) -> Sign {
  case a {
    a if a > 0 -> Positive
    a if a == 0 -> Zero
    _ -> Negative
  }
}

pub fn rotate(position: Int, distance: Int, count: Int) -> Int {
  case sign(distance) {
    Zero -> 0
    Positive ->
      case distance {
        x if x > 100 -> rotate(position, distance - 100, count + 1)
        x if position + x >= 100 -> count + 1
        _ -> count
      }
    Negative ->
      case distance {
        x if x < -100 -> rotate(position, distance + 100, count + 1)
        x if position + x <= 0 -> count + 1
        _ -> count
      }
  }
}

pub fn day1_part2(content: String) {
  content
  |> string.split(on: "\n")
  |> list.map(parse_line)
  |> result.values
  |> list.map_fold(from: 50, with: fn(acc, a) {
    let assert Ok(new_position) = int.modulo(acc + a, 100)

    let times_past_zero = rotate(acc, a, 0)

    #(new_position, times_past_zero)
  })
  |> pair.second
  |> list.fold(from: 0, with: fn(acc, a) { acc + a })
  |> echo
}

pub fn main() {
  let assert Ok(content) = simplifile.read("./src/inputs/day_1.txt")
  day1_part1(content)
  day1_part2(content)
}

pub type ParseError {
  InvalidEmpty
  InvalidDirection
  InvalidDistance
}

pub fn parse_line(line: String) -> Result(Int, ParseError) {
  case string.pop_grapheme(line) {
    Ok(#(direction, distance_str)) ->
      case int.parse(distance_str) {
        Ok(distance) ->
          case direction {
            "R" -> Ok(distance)
            "L" -> Ok(-distance)
            _ -> Error(InvalidDirection)
          }
        Error(_) -> Error(InvalidDistance)
      }
    Error(_) -> Error(InvalidEmpty)
  }
}
