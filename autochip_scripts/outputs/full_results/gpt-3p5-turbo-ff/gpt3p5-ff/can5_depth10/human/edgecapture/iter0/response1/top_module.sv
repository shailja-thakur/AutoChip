module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] in_prev;
	always @(posedge clk or posedge reset) begin
		if (reset)
			in_prev <= 32'b0;
		else begin
			in_prev <= in;
			out <= in_prev & ~in;
		end
	end
    
endmodule
