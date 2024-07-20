module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] dff [7:0];
	
	always @(posedge clk) begin
		if (reset)
			q <= 8'b0;
		else begin
			q <= dff[7];
			dff[7] <= d[7];
			dff[6] <= d[6];
			dff[5] <= d[5];
			dff[4] <= d[4];
			dff[3] <= d[3];
			dff[2] <= d[2];
			dff[1] <= d[1];
			dff[0] <= d[0];
		end
	end
	
endmodule
