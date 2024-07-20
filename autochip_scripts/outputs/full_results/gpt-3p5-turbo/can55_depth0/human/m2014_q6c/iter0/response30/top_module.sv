module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State signal assignments
	parameter A = 6'b000001;
	parameter B = 6'b000010;
	parameter C = 6'b000100;
	parameter D = 6'b001000;
	parameter E = 6'b010000;
	parameter F = 6'b100000;
	
	// Combinational logic for Y2
	assign Y2 = (y == B) ? w : 1'b0;
	
	// Combinational logic for Y4
	assign Y4 = (y == D || y == E) ? ~w : 1'b0;
	
endmodule
