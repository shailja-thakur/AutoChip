// 
The module has 3 inputs. y input is a 4 bits input, w is a 1 bit input, Y2 is a 1 bit reg output.
It is an always_comb block, not an always_ff block.
So there is no state transitions and clock.
Every time a new input comes, the output will be changed immediately.

It is a case statement, the left hand side is a combination of inputs(y, w).
The right hand side is the output(Y2).
If the input is 4'h0, the output will be 0.
If the input is 4'h1, the output will be 0.
If the input is 4'h2, the output will be 1.
If the input is 4'h3, the output will be 1.
If the input is 4'h4, the output will be 0.
If the input is 4'h5, the output will be 1.
If the input is 4'h6, the output will be 0.
If the input is 4'h7, the output will be 0.
If the input is 4'h8, the output will be 0.
If the input is 4'h9, the output will be 1.
If the input is 4'ha, the output will be 1.
If the input is 4'hb, the output will be 1.



module top_module(
	input [3:1] y,
	input w,
	output reg Y2);
