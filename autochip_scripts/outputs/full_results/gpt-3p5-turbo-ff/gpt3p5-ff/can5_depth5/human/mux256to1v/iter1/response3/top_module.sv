module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

genvar i;
generate
	for (i = 0; i < 256; i = i + 1) begin
		wire [3:0] in_sel;
		assign in_sel = in[i*4 +: 4];
		
		if (i == sel) begin
			assign out = in_sel;
		end
	end
endgenerate

endmodule
