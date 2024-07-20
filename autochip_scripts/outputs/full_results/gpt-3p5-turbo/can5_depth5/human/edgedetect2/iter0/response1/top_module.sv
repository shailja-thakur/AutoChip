module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	// Register to store the previous value of in
	reg [7:0] prev_in;
	
	// Always block to detect edge
	always @(posedge clk) begin
		prev_in <= in;
		
		for (integer i = 0; i < 8; i = i + 1) begin
			if (in[i] && !prev_in[i])
				anyedge[i] <= 1'b1;
			else
				anyedge[i] <= 1'b0;
		end
	end
endmodule
