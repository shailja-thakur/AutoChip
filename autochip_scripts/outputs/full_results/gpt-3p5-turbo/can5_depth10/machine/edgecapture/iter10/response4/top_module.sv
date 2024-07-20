module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] d_last;
	initial d_last = 0;
	reg [31:0] out_reg;
	always @(posedge clk) begin
		if (reset) begin
			out_reg <= 0;
		end else begin
			out_reg <= out_reg | (~in & d_last);
			d_last <= in;
		end
	end
	assign out = out_reg;

endmodule
