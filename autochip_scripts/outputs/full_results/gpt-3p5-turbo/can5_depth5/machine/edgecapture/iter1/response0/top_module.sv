module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);
	
	reg [31:0] d_last;
	reg [31:0] temp_out;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 0;
			d_last <= 0;
		end else begin
			d_last <= in;
			temp_out <= out;
			out <= temp_out | (~in & d_last);
		end
	end
	
endmodule
