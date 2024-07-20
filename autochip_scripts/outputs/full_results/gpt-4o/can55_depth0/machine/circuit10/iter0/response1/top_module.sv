module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

	reg c;

	// Sequential block to update register 'c'
	always @(posedge clk) begin
		c <= (a & b) | (a & c) | (b & c);
	end

	// Combinational block to calculate outputs
	always @(*) begin
		q = a ^ b ^ c;
		state = c;
	end

endmodule
