module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Signal to store the previous value of in
	reg [31:0] d_last;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 0; // Initialize out to 0 when reset is asserted
		end else begin
			// Assign the value of in ORed with the NOT of in ANDed with the previous value of in
			out <= out | (~in & d_last);
			d_last <= in; // Store the current value of in in d_last
		end
	end

endmodule
