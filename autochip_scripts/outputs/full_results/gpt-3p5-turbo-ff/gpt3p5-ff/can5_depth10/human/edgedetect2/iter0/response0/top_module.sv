module top_module (
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge
);
	always @(posedge clk) begin
		for (integer i = 0; i < 8; i = i + 1) begin
			if (in[i] && !in[i]) begin
				anyedge[i] <= 1'b1;
			end
			else begin
				anyedge[i] <= 1'b0;
			end
		end
	end
endmodule
