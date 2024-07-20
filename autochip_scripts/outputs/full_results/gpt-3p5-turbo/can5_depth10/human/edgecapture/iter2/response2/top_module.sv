module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Internal signal to store the previous value of the input signal
	reg [31:0] previous_in;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;
			
			// Check for falling edge (from 1 to 0)
			out <= out | (previous_in & ~in);
		end
	end

endmodule
