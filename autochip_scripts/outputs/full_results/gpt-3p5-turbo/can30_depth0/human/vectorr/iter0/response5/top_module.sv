module top_module (
	input [7:0] in,
	output [7:0] out
);
	// Create an intermediate wire to hold the reversed bits
	wire [7:0] reversed;
	
	// Reverse the bit ordering using a for loop
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) begin
			assign reversed[i] = in[7 - i];
		end
	endgenerate
	
	// Assign the reversed signal to the output
	assign out = reversed;
endmodule
