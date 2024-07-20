module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);
	
	//Store previous value of 'in'
	reg [31:0] d_last;
	
	always @(posedge clk) begin
		d_last <= in;
		if (reset)
			out <= 32'h0;
		else
			out <= out | (~in & d_last);
	end

endmodule
