// The top module has 8 inputs and 2 outputs.

The inputs are:
- clk
- load
- ena
- amount[1:0]
- data[63:0]

The outputs are:
- q[63:0]

The top module has 1 always block.

The block is triggered by a rising edge of clk.

The always block has 1 if block.

The if block has a condition load and an else if block.

The else if block has a condition ena and 1 case block.

The case block has 4 case items, 00, 01, 10, 11, and 1 default item.

The case item 00 has 1 assignment.

The assignment is q = {q[62:0], 1'b0}

The case item 01 has 1 assignment.

The assignment is q = {q[55:0], 8'b0}

The case item 10 has 1 assignment.

The assignment is q = {q[63], q[63:1]}

The case item 11 has 1 assignment.

The assignment is q = {{8{q[63]}}, q[63:8]}

The default item has 1 assignment.

The assignment is q = 64'hx



module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);
