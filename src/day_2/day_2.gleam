import gleam/int
import gleam/list
import gleam/pair
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("./src/day_2/inputs/input.txt")
  let numbers =
    string.split(content, on: ",")
    |> list.map(with: string.trim)
    |> list.map(with: fn(x) {
      let assert Ok(#(left_raw, right_raw)) = string.split_once(x, on: "-")
      let assert Ok(left) = int.parse(left_raw)
      let assert Ok(right) = int.parse(right_raw)
      list.range(left, right)
    })
  part_1(numbers)
  part_2(numbers)
}

fn part_2(content: List(List(Int))) {
  content
  |> list.map(with: fn(a) {
    list.filter(a, keeping: fn(x) { is_id_invalid_part_two(x) })
  })
  |> list.flatten
  |> int.sum
  |> echo
}

fn part_1(content: List(List(Int))) {
  content
  |> list.map(with: fn(a) {
    list.filter(a, keeping: fn(x) { is_id_invalid(x) })
  })
  |> list.flatten
  |> int.sum
  |> echo
}

pub fn is_id_invalid_part_two(id: Int) -> Bool {
  int.to_string(id)
  |> to_the_window
}

pub fn to_the_window(number: String) -> Bool {
  // echo "string.length"
  // echo string.length(number)
  let x = string.length(number)
  to_the_window_loop(string.to_graphemes(number), 1, { x / 2 } - 1)
}

pub fn to_the_window_loop(list: List(String), window_size: Int, i: Int) -> Bool {
  // echo "list"
  // echo list
  // echo "window_size"
  // echo window_size
  // echo "i"
  // echo i
  let result =
    list.sized_chunk(list, window_size)
    |> fn(x) {
      let assert Ok(first) = list.first(x)
      // echo "first"
      // echo first
      // echo x

      list.all(x, fn(a) { a == first })
      // |> echo
    }
  case result {
    True -> True
    False if i == 0 -> False
    False -> to_the_window_loop(list, window_size + 1, i - 1)
  }
}

fn split_string_in_half(s: String) -> Result(#(List(String), List(String)), Nil) {
  case string.length(s) {
    len if len % 2 != 0 -> Error(Nil)
    len -> {
      Ok(
        string.to_graphemes(s)
        |> list.split(at: len / 2),
      )
    }
  }
}

pub fn is_id_invalid(id: Int) -> Bool {
  int.to_string(id)
  |> split_string_in_half
  |> result.map(with: fn(a) { pair.first(a) == pair.second(a) })
  |> result.unwrap(or: False)
}
