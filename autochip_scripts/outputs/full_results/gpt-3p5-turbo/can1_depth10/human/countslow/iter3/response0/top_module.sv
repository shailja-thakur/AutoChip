module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	// Internal signal for synchronous reset
	reg reset_sync;
	
	reg [3:0] count;
	
	always @(posedge clk) begin
		if (reset)
			reset_sync <= 1'b1;
		else if (slowena)
			reset_sync <= 1'b0;
	end
	
	always @(posedge clk) begin
		if (reset_sync)
			count <= 4'b0;
		else if (slowena)
			count <= count + 1;
	end
	
	assign q = count;
	
endmodule
