module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	reg [7:0] internal_q;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			internal_q <= 0;
		else
			internal_q <= d;
	end
	
	assign q = internal_q;
endmodule
