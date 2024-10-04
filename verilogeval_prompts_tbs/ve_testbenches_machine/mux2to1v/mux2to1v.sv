//  This module is a simple multiplexer that takes two inputs a and b, and a select signal sel. Depending on the value of sel, the output out will be either a or b. If sel is 0, then out will be equal to a, and if sel is 1, then out will be equal to b. This module is useful for selecting between two different inputs depending on the value of the select signal.

module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);
