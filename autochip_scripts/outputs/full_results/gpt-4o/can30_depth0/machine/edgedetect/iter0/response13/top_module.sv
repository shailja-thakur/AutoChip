module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	// Register to store the value of the input signal from the previous clock cycle
	reg [7:0] d_last;

	always @(posedge clk)
	begin
		// Store the current value of the 8-bit input signal in the d_last register
		d_last <= in;
		
		// Calculate the 8-bit output signal, pedge
		pedge <= in & ~d_last;
	end

endmodule
