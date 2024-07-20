module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] in_sliced [31:0];

genvar i;

generate
	for (i=0; i<32; i=i+1) begin: slicing
		assign in_sliced[i] = in[(i*32)+:4];
	end
endgenerate

assign out = in_sliced[sel];

endmodule
