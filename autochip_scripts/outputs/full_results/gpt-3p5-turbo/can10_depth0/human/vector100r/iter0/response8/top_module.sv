module top_module (
	input [99:0] in,
	output reg [99:0] out
);

	always @(in)
	begin
		for (int i = 0; i < 100; i++)
			out[i] = in[99 - i];
	end
	
endmodule
