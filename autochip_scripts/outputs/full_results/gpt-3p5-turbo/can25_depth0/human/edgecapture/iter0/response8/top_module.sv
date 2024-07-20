module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			for (integer i=0; i<32; i=i+1) begin
				if (in[i] == 1'b1 && in[i] != $past(in[i]))
					out[i] <= 1;
				else if (out[i] == 1 && in[i] == 1'b0)
					out[i] <= 0;
			end
		end
	end

endmodule
