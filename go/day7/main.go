package main

import (
	"bytes"
	"fmt"
	"os"
	"slices"
)

func must[T any](t T, err error) T {
	if err != nil {
		panic(err)
	}
	return t
}

func main() {
	content := must(os.ReadFile("./input/day7/input.txt"))
	// fmt.Println(part1(content))
	fmt.Println(part2(content))
}

func getStartingPoint(content []byte) (int, int) {
	row := 0
	col := 0
	for _, b := range content {
		if b == '\n' {
			row++
			col = 0
			continue
		}
		if b == 'S' {
			return row, col
		}
		col++
	}
	panic("no starting point")
}

type Laser struct {
	x int
}

func part2(content []byte) string {
	_, col := getStartingPoint(content)

	rows := bytes.Split(content, []byte{'\n'})
	fmt.Println("rows", len(rows), len(rows[0]))
	cache = New(len(rows), len(rows[0]))

	// go through each row
	fmt.Println(traverse(rows, 1, col) + 1)

	fmt.Println(calls)
	return ""
}

var calls int

// its faster than a map
var (
	cache syncCache
)

type syncCache struct {
	cacheRaw []int
	columns  int
}

func New(rows, columns int) syncCache {
	return syncCache{
		cacheRaw: make([]int, rows*columns),
		columns:  columns,
	}
}

func (s *syncCache) Set(x, y, value int) {
	s.cacheRaw[x*s.columns+y] = value
}

func (s *syncCache) Get(x, y int) (int, bool) {
	return s.cacheRaw[x*s.columns+y], s.cacheRaw[x*s.columns+y] != 0
}

func traverse(graph [][]byte, x, y int) (result int) {
	if result, ok := cache.Get(x, y); ok {
		return result
	}
	defer func() {
		cache.Set(x, y, result)
	}()
	if x >= len(graph) {
		return 0
	}
	if y >= len(graph[x]) {
		return 0
	}
	if graph[x][y] == '^' {
		var result1, result2 int
		result1 = traverse(graph, x+1, y-1)
		result2 = traverse(graph, x+1, y+1)
		return 1 + result1 + result2
	} else {
		return traverse(graph, x+1, y)
	}
}

func part1(content []byte) string {
	_, col := getStartingPoint(content)
	lasers := []Laser{
		{
			x: col,
		},
	}

	rows := bytes.Split(content[:], []byte{'\n'})
	var splits int
	// go through each row
	for _, row := range rows[1:] {
		if len(row) == 0 {
			continue
		}
		fmt.Println("row", string(row))
		// move laser down or split
		for i, laser := range lasers {
			switch row[laser.x] {
			case '^':
				lasers[i].x = laser.x - 1
				lasers = append(lasers, Laser{laser.x + 1})
				splits++
			case '.':
				// nothing, the column stays the same
			}
		}
		lasers = mergeLasers(lasers)
	}
	fmt.Println(splits)

	return ""
}

func mergeLasers(lasers []Laser) []Laser {
	var newLasers []Laser
	for _, laser := range lasers {
		if !slices.Contains(newLasers, laser) {
			newLasers = append(newLasers, laser)
		}
	}
	return newLasers
}
