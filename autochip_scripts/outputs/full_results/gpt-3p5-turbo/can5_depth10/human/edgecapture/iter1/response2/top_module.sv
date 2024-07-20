module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Internal signals to detect rising edge of each bit in the input signal
	reg [31:0] previous_in;
	reg [31:0] rising_edge;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;
			
			// Check for rising edge
			rising_edge <= previous_in & ~in;
			
			// Set the corresponding bits in the output signal to 1 when a rising edge is detected
			out <= out | rising_edge;
		end
	end

endmodule
