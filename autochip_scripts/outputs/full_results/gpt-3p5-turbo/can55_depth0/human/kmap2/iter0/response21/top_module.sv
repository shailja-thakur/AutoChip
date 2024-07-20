module top_module (
	input wire a, 
	input wire b,
	input wire c,
	input wire d,
	output wire out
);
	
	// Implement the truth table using assign statements
	assign out = (~a & ~b & c & ~d) | (~a & b & ~c & ~d) | (a & ~b & c & d) | (a & b & c & d);

endmodule
