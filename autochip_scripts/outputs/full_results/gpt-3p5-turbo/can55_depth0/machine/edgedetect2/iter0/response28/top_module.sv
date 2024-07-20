module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] d_last; // register to store previous value of the in signal

	always @(posedge clk) begin
		d_last <= in;  // store the current value of in signal in d_last register
		anyedge <= in ^ d_last; // calculate the XOR of in signal and d_last register to detect edge
	end

endmodule
