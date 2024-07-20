module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Internal signals to detect rising edge of each bit of the input signal
	reg [31:0] previous_in;
	reg [31:0] rising_edge;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;
			
			// Detect Rising Edge
			rising_edge <= (previous_in ^ in) & ~in;
			
			// Capture the rising edge into out
			out <= (out | rising_edge) & ~reset;
		end
	end

endmodule
