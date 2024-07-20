module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	reg [7:0] q_dff [0:7];
	always @(posedge clk)
	begin
		for (int i = 0; i < 8; i=i+1)
		begin
			q_dff[i] <= d[i];
		end
	end

	always @*
	begin
		for (int i = 0; i < 8; i=i+1)
		begin
			q[i] <= q_dff[i];
		end
	end

endmodule
