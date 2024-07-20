module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);
	
	// Internal signals
	reg [3:0] q_temp;

	// Counter logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			q_temp <= 0;
		else if (slowena)
			q_temp <= q_temp + 1;
	end

	// Output assignment
	assign q = q_temp;

endmodule
