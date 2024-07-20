module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] d_last; // register to store the previous value of 'in' signal

	always @(posedge clk) begin
		d_last <= in; // update d_last with the current value of 'in' signal
		anyedge <= in ^ d_last; // calculate anyedge by performing XOR operation between current value and previous value
	end
endmodule
