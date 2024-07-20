module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev_in;

	always @(posedge clk) begin
		for (integer i = 0; i < 8; i = i+1) begin
			if (!prev_in[i] && in[i])
				anyedge[i] <= 1;
			else
				anyedge[i] <= 0;
			prev_in[i] <= in[i];
		end
	end

initial begin
	prev_in <= 8'b0;
end

endmodule
