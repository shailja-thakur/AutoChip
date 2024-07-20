module top_module(
	input clk,
	input d,
	output reg q);

	reg d_ff1, d_ff2;
	always @(posedge clk)
	begin
		// create a positive edge-triggered flip-flop
		d_ff1 <= d;
	end

	always @(posedge clk)
	begin
		// create a negative edge-triggered flip-flop
		d_ff2 <= d_ff1;
	end

	always @(posedge clk)
	begin
		// output the value of the negative edge-triggered flip-flop
		q <= d_ff2;
	end

endmodule
