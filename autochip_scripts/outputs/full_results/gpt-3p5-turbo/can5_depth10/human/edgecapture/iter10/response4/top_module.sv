module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] previous_in;

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;
			
			for (integer i = 0; i < 32; i = i + 1) begin
				if (previous_in[i] == 1 && in[i] == 0)
					out[i] <= 1;
			end
		end
	end

	always @(in) begin
		if (in == 0) // Reset the output when input is 0
			out <= 0;
	end

endmodule
