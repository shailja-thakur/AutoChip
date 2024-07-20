module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	/* Register to store previous value of the input signal */
	reg [7:0] d_last;

	always @(posedge clk) begin
		/* Store the current value of the input signal */
		d_last <= in;
		
		/* Calculate the output signal */
		pedge <= in & (~d_last);
	end
endmodule
