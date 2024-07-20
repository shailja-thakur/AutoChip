module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Internal registers to capture the input signal changes
	reg [31:0] prev_in;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			prev_in <= 0;
			out <= 0;
		end else begin
			prev_in <= in;
			out <= 0;
			for (integer i = 0; i < 32; i = i + 1) begin
				if (prev_in[i] && !in[i]) // Signal changed from 1 to 0
					out[i] <= 1;
			end
		end
	end

endmodule
