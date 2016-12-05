#!/usr/bin/env io

filename := System args at(1)

if (filename == nil,
  "Usage: io 1.io <input-filename>" println
  "No input file specified. Exiting.." println
  System exit(0)
)

# Just stores the one-line input from file into `input`
f := File with(filename)
f openForReading
input := f readLine

# Split into tokens (R1, R2, L1, L2)
tokens := input split(", ")

# 0 -> NORTH, 1 -> EAST, 2 -> SOUTH, 3 -> WEST
Direction := Object clone
Direction value := 0
Direction turnLeft := method(
  (value == 0) ifTrue (value = 3) ifFalse (value = value - 1)
)
Direction turnRight := method(
  (value == 3) ifTrue (value = 0) ifFalse (value = value + 1)
)

direction := Direction clone

Offset := Object clone
Offset x := 0
Offset y := 0
Offset getDistance := method(
  x abs + y abs
)

offset := Offset clone

tokens foreach(k, v,
  dir := v at(0) asCharacter
  num := v exSlice(1) asNumber

  write("[", offset x, ",", offset y, "]")
  write("<", dir, ",", num, ">")

  if (dir == "L", direction turnLeft)
  if (dir == "R", direction turnRight)

  # 0 -> NORTH, 1 -> EAST, 2 -> SOUTH, 3 -> WEST
  "{" print
  num print
  if (direction value == 0, offset y = offset y + num; "N}" print)
  if (direction value == 1, offset x = offset x + num; "E}" print)
  if (direction value == 2, offset y = offset y - num; "S}" print)
  if (direction value == 3, offset x = offset x - num; "W}" print)
  "\n" print
)

offset getDistance println

