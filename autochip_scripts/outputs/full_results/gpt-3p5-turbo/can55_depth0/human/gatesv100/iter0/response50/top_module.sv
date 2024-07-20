module top_module (
	input [99:0] in,
	output reg [98:0] out_both,
	output reg [99:1] out_any,
	output reg [99:0] out_different
);
  
	always @* begin
		for(int i = 0; i < 99; i=i+1) begin
			out_both[i] = in[i] & in[i+1];
			out_any[i+1] = in[i] | in[i+1];
			if (i == 99)
				out_any[0] = in[99];
			out_different[i] = (in[i] != in[(i+99)%100]);
		end
	end
endmodule
