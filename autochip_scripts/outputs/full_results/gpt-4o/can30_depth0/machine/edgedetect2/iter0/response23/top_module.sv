module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);
	
	reg [7:0] d_last;
	
	initial begin
		d_last = 0;
		anyedge = 0;
	end
	
	always @(posedge clk) begin
		anyedge <= in ^ d_last;
		d_last <= in;
	end

endmodule
