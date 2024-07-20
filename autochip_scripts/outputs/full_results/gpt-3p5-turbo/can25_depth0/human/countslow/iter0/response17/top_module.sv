module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	// internal signals
	reg [3:0] counter_next;

	always @(posedge clk or posedge reset) begin
		if (reset)
			counter_next <= 4'b0000;
		else if (slowena)
			counter_next <= q + 1;
		else
			counter_next <= q;
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= counter_next;
		end
	end
endmodule
