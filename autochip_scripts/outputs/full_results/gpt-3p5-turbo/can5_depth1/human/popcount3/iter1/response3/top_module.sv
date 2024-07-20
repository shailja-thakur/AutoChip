module top_module (
	input [2:0] in,
	output reg [1:0] out
);

	always @(*)
	begin
		out = 0;  // Initialize the output to 0
		
		// Perform population count
		if (in[0] == 1)
			out = out + 1;
		if (in[1] == 1)
			out = out + 1;
		if (in[2] == 1)
			out = out + 1;
	end
endmodule
