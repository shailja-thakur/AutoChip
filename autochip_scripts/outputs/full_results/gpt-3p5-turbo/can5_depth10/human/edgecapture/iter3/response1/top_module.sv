module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Internal signal to detect rising edge of the input signal
	reg [31:0] previous_in;
	reg [31:0] out_reg; // Output register to store the captured values
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			out_reg <= 0;
		else begin
			previous_in <= in;
			
			// Check for rising edge
			out_reg <= out_reg | (previous_in & ~in);
		end
	end
	
	// Assign the output from the register to the output port
	assign out = out_reg;

endmodule
