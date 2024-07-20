module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] previous_in;
	reg [31:0] prev_out;

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;
			
			// Check for rising edge
			prev_out <= out;
			for (integer i = 0; i < 32; i = i+1) begin
				if (previous_in[i] & ~in[i])
					out[i] <= 1;
			end
		end
	end
	
	always @(posedge clk) begin
		if (reset)
			out <= 0;
	end

endmodule
