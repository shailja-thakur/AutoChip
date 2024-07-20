module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Internal signal to capture the change from 1 to 0
	reg [31:0] prev_in;

	always @(posedge clk, posedge reset) begin
		if (reset)
			prev_in <= 32'b0;    // Reset the previous input value
		else
			prev_in <= in;       // Capture the current input value
	end

	// Logic to detect the change from 1 to 0 and capture it
	always @(posedge clk, posedge reset) begin
		if (reset)
			out <= 32'b0;        // Reset the output value
		else
			out <= prev_in & (~in);  // Capture the change from 1 to 0
	end

endmodule
