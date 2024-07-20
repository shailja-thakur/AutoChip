module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// Define state encodings for better readability
	localparam A = 6'b000001;
	localparam B = 6'b000010;
	localparam C = 6'b000100;
	localparam D = 6'b001000;
	localparam E = 6'b010000;
	localparam F = 6'b100000;

	// Determine the value of Y1
	assign Y1 = (y == A && w)  ? 1'b1 :  // A --1--> B
	            (y == B && !w) ? 1'b1 :  // B --0--> D
	            1'b0;

	// Determine the value of Y3
	assign Y3 = (y == B && !w) ? 1'b1 :  // B --0--> D
	            (y == C && !w) ? 1'b1 :  // C --0--> D
	            (y == D && !w) ? 1'b1 :  // D --0--> A
	            (y == E && !w) ? 1'b1 :  // E --0--> D
	            (y == F && !w) ? 1'b1 :  // F --0--> D
	            1'b0;

endmodule
