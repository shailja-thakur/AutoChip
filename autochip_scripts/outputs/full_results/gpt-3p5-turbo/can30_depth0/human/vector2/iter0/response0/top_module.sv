module top_module (
	input [31:0] in,
	output [31:0] out
);
	// Create a wire to hold the reversed byte order of the input
	wire [31:0] reversed;
	
	// Reverse the byte order by assigning the corresponding bytes from the input to the reversed wire
	assign reversed = {in[7:0],in[15:8],in[23:16],in[31:24]};
	
	// Assign the reversed byte order to the output
	assign out = reversed;
endmodule
