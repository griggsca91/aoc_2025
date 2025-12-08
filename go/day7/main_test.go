package main

import (
	"bytes"
	"os"
	"testing"
)

func BenchmarkTraverse(b *testing.B) {
	content := must(os.ReadFile("/Users/chris/aoc/aoc_2025/go/input/day7/input.txt"))
	_, col := getStartingPoint(content)
	rows := bytes.Split(content, []byte{'\n'})
	cache = New(len(rows), len(rows[0]))
	b.ResetTimer()
	for b.Loop() {
		_ = traverse(rows, 1, col)
	}
}
