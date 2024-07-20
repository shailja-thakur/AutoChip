module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

	// Internal register to store value of c
	reg c;

	// Always block for sequential logic
	always @(posedge clk) begin
		// Calculate the value of c
		c <= (a & b) | (a & c) | (b & c);
		// Calculate the outputs q and state
		q <= a ^ b ^ c;
		state <= c;
	end

endmodule
