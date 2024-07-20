module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] d_last; // signal to store the previous value of in

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0; // reset the value of out to 0
		else begin
			d_last <= in; // store the current value of in to d_last
			out <= out | (~in & d_last); // modify the value of out
		end
	end
endmodule
