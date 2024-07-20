module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Register to store the previous value of 'in'
	reg [31:0] d_last;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset the output and previous input values
			out <= 32'b0;
			d_last <= 32'b0;
		end else begin
			// Store the current 'in' value in 'd_last'
			d_last <= in;
			// Modify the 'out' value
			out <= out | (~in & d_last);
		end
	end

endmodule
