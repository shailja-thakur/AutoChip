module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Declare internal wire
	wire q;

	// Define the logic for q
	assign q = ~(a & b & c & d);

endmodule
