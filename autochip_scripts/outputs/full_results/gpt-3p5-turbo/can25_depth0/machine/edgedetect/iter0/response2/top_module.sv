module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	
	// Register to store the previous value of the input signal
	reg [7:0] d_last;
	
	// Always block triggered by the rising edge of the clock
	always @(posedge clk) begin
		// Store the current value of the input signal in d_last
		d_last <= in;
		
		// Calculate the output signal pedge using bitwise AND operation
		pedge <= in & ~d_last;
	end
endmodule
