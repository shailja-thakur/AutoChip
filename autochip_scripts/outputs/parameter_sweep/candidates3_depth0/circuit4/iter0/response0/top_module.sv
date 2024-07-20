module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Declare the wire q_temp to store the intermediate result
	wire q_temp;

	// Implement the logic for q
	assign q_temp = (~a & ~b & ~c & ~d) | (~a & ~b & c & ~d) | (~a & b & ~c & ~d) | (~a & b & c & ~d) | (~a & b & c & d) | (a & b & ~c & ~d) | (a & b & c & ~d) | (a & b & c & d);
	assign q = q_temp;

endmodule
