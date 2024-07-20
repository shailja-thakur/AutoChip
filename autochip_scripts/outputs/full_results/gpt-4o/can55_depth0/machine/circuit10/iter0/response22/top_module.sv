module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

	reg c;

	// Sequential logic for register 'c'
	always @(posedge clk) begin
		c <= (a & b) | (a & c) | (b & c);
	end

	// Combinational logic for outputs 'q' and 'state'
	always @(posedge clk) begin
		q <= a ^ b ^ c;
		state <= c;
	end

endmodule
