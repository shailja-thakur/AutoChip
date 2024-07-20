module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);
	
	// register to store previous value of input signal
	reg [7:0] d_last;
	
	always @(posedge clk) begin
		// detect any edge on the in signal
		anyedge <= in ^ d_last;
		
		// update d_last with the current value of in
		d_last <= in;
	end
endmodule
