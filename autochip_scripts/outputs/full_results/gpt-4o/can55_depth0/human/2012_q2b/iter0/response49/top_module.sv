module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

// State assignment
localparam A = 6'b000001;
localparam B = 6'b000010;
localparam C = 6'b000100;
localparam D = 6'b001000;
localparam E = 6'b010000;
localparam F = 6'b100000;

// Generate Y1 (Input for state B)
assign Y1 = (y == A && w) || (y == F && w);

// Generate Y3 (Input for state D)
assign Y3 = (y == B && ~w) || (y == C && ~w) || (y == D && ~w) || (y == E && ~w) || (y == F && ~w);

endmodule
