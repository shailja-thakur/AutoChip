module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output reg [99:0] out_different
);

	always @* begin
		out_both = in[98:0] & (in[99:1] << 1);
		out_any = in | (in << 1);
		
		// Generate out_different
		out_different[0] = in[0] ^ in[99];
		for (int i = 0; i < 99; i = i + 1) begin
			out_different[i+1] = in[i] ^ in[i+1];
		end
	end
	
endmodule
