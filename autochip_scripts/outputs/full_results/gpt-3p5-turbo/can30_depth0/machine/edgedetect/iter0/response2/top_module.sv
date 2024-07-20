module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	// register to store previous input value
	reg [7:0] d_last;

	always @(posedge clk) begin
		// store current input value in d_last
		d_last <= in;
		
		// calculate output signal pedge
		pedge <= in & ~d_last;
	end
	
endmodule
