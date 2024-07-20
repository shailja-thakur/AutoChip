module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] previous_in;
	reg [31:0] capture_mask;

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;

			// Calculate capture mask
			capture_mask <= previous_in & ~in;

			// Update output based on capture mask
			out <= out | capture_mask;
		end
	end

endmodule
