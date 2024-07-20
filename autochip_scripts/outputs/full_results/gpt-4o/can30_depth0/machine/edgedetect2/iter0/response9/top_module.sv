module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] d_last; // Register to store the previous value of the input signal

	always @(posedge clk) begin
		d_last <= in; // Update d_last with the current value of the in signal
		anyedge <= in ^ d_last; // Calculate the anyedge output signal
	end

endmodule
