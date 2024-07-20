module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	// Always block triggered on the rising edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset) 
			q <= 8'b0; // When reset is high, set q to 0
		else
			q <= d; // Otherwise, set q to the value of d
	end

endmodule
