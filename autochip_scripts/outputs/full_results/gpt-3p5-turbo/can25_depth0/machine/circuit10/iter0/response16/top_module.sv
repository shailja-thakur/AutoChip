module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
	// Declare internal signals
	reg c;

	// Register to store value of c
	always @(posedge clk) begin
		c <= (a & b) | (a & c) | (b & c);
	end

	// Assign outputs
	assign q = a ^ b ^ c;
	assign state = c;

endmodule
