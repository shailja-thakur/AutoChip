module top_module(
	input clk,
	input d,
	output reg q);


	// Creating positive edge-triggered D flip-flop
	always @(posedge clk)
	begin
		q <= d;
	end

endmodule
