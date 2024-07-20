module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Internal signal to detect rising edge of the input signal
	reg [31:0] previous_in;
	reg [31:0] detect_rising_edge;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;
			
			// Check if input signal has a rising edge
			detect_rising_edge <= previous_in & ~in;
			
			// Set corresponding bits in the output register if rising edge detected
			out <= out | detect_rising_edge;
		end
	end

endmodule
