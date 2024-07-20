module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	reg [7:0] idx;
	assign idx = sel;
	
	always @* begin
		if (idx >= 256)
			out = 0;
		else
			out = in[idx];
	end
	
endmodule
