module top_module(
	input clk,
	input d,
	output reg q);

		always @(posedge clk or negedge clk) begin
			if(clk) begin
				q <= d;
			end else begin
				q <= d;
			end
		end
endmodule
