module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	always @(posedge clk) begin
		if(reset)
			q <= 0;  // Reset the register to 0
		else
			q <= d;  // Set the value of q to the value of d
	end

endmodule
