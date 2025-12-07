package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func must[T any](t T, err error) T {
	if err != nil {
		panic(err)
	}
	return t
}

func main() {
	content := must(os.ReadFile("./input/day6/input.txt"))
	// fmt.Println(part1(content))
	fmt.Println(part2(content))
}

func part1(content string) int {
	results := parseContentPart1(content)
	var r int
	for _, v := range results {
		r += v
	}
	return r
}

func part2(content []byte) int {
	arguments, operators := parseContentPart2(string(content))

	results := make([]int, len(operators))

	// last line is the operators
	for col, o := range operators {
		for i, arg := range arguments[col] {
			if i == 0 {
				results[col] = arg
			} else {
				results[col] = o(arg, results[col])
			}
		}
		fmt.Println(results[col])
	}

	var result int
	for _, r := range results {
		result += r
	}
	return result
}

type operator func(int, int) int

func parseOperator(s string) operator {
	switch s {
	case "+":
		return Add
	case "*":
		return Multiply
	default:
		panic(fmt.Sprintf("%s don't exist bud", s))
	}
}

func Multiply(x, y int) int {
	fmt.Println("multiply", x, y)
	return x * y
}

func Add(x, y int) int {
	fmt.Println("add", x, y)

	return x + y
}

func parseContentPart2(content string) ([][]int, []operator) {
	lines := strings.Split(content, "\n")
	cols := len(lines[0])
	var chars [][]string
	for _, l := range lines {
		if len(l) == 0 {
			continue
		}
		fmt.Println("len", len(l))
		chars = append(chars, strings.Split(l, ""))
	}

	printMatrix(chars)

	var arguments []int
	results := [][]int{}
	for i := range cols {
		if isColumnEmpty(chars, i) {
			// new line
			results = append(results, arguments)
			arguments = []int{}
			continue

		}

		arguments = append(arguments, getColumnValues(chars[:len(chars)-1], i))
		fmt.Println(arguments)
	}

	results = append(results, arguments)

	var operators []operator
	for _, o := range strings.Fields(lines[len(lines)-2]) {
		fmt.Println("o", o)
		operators = append(operators, parseOperator(o))
	}

	fmt.Println(results)
	fmt.Println(operators)

	return results, operators
}

func isColumnEmpty(c [][]string, col int) bool {
	for _, row := range c {
		if row[col] != " " {
			return false
		}
	}
	return true
}

func getColumnValues(c [][]string, col int) int {
	s := make([]string, len(c))
	for i := range c {
		s[i] = c[i][col]
	}
	return must(strconv.Atoi(strings.TrimSpace(strings.Join(s, ""))))
}

func printMatrix(c [][]string) {
	for i := range c {
		for j := range c[i] {
			p := c[i][j]
			if c[i][j] == " " {
				p = "_"
			}
			fmt.Printf("%s ", p)
		}
		fmt.Println()
	}
}

func parseContentPart1(content string) []int {
	lines := strings.Split(content, "\n")

	var operators []operator

	for _, o := range strings.Fields(lines[len(lines)-1]) {
		operators = append(operators, parseOperator(o))
	}
	fmt.Println(operators)

	results := make([]int, len(operators))

	// last line is the operators
	for _, l := range lines[:len(lines)-1] {
		for col, v := range strings.Fields(l) {
			value := must(strconv.Atoi(v))
			if results[col] == 0 {
				results[col] = value
			} else {
				results[col] = operators[col](value, results[col])
			}
			fmt.Println(results[col])
		}
	}

	fmt.Println(results)
	return results
}
