module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Define the D flip-flop module
	module d_ff (
		input clk,
		input resetn,
		input d,
		output reg q
	);
		always @(posedge clk or negedge resetn) begin
			if (~resetn)
				q <= 0;
			else
				q <= d;
		end
	endmodule
