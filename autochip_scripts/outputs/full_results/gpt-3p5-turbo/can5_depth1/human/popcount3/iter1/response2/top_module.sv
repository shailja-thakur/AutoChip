module top_module (
	input [2:0] in,
	output [1:0] out
);
	
	always @* begin
		out[0] = in[0] & in[1];  // Perform AND gate operation on the 0th and 1st bits of the input
		out[1] = out[0] & in[2];  // Perform AND gate operation on the previous AND output and the 2nd bit of the input
	end
	
endmodule
