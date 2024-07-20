module top_module(
	input wire clk,
	input wire reset,
	input wire [31:0] in,
	output reg [31:0] out);

	reg [31:0] d_last;

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 32'b0;
		else
			out <= out | (~in & d_last);
		
		d_last <= in;
	end

endmodule
