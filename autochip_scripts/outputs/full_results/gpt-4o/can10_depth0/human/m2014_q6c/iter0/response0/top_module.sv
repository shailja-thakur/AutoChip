module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State Encoding
	localparam A = 6'b000001;
	localparam B = 6'b000010;
	localparam C = 6'b000100;
	localparam D = 6'b001000;
	localparam E = 6'b010000;
	localparam F = 6'b100000;
	
	// Next-state logic for Y2
	assign Y2 = (y == B && !w) || (y == C && !w) || (y == E && !w);

	// Next-state logic for Y4
	assign Y4 = (y == B && w) || (y == C && w) || (y == F && w);
	
endmodule
