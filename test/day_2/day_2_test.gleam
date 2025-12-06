import day_2/day_2
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn is_id_invalid_test() {
  assert day_2.is_id_invalid(11) == True
  assert day_2.is_id_invalid(12) == False
  assert day_2.is_id_invalid(101) == False
  assert day_2.is_id_invalid(1_188_511_885) == True
}

pub fn is_id_invalid_part_two_test() {
  assert day_2.is_id_invalid_part_two(9999) == True
  assert day_2.is_id_invalid_part_two(222_222) == True
  assert day_2.is_id_invalid_part_two(11) == True
  assert day_2.is_id_invalid_part_two(111) == True
  assert day_2.is_id_invalid_part_two(12) == False
  assert day_2.is_id_invalid_part_two(101) == False
  assert day_2.is_id_invalid_part_two(1_188_511_885) == True
  assert day_2.is_id_invalid_part_two(38_593_859) == True
  assert day_2.is_id_invalid_part_two(2_121_212_121) == True
  assert day_2.is_id_invalid_part_two(565_656) == True
  assert day_2.is_id_invalid_part_two(824_824_824) == True
}
