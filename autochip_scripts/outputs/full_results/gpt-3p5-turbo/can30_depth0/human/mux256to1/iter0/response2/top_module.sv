module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [255:0] in_bits;
wire [255:0] out_bits;
assign in_bits = in & {8{sel}};
assign out = out_bits[0];

mux_256_to_1 mux (
	.in(in_bits),
	.sel(sel),
	.out(out_bits)
);

endmodule
module mux_256_to_1 (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

genvar i;

generate
    for (i = 0; i < 256; i = i + 1) begin: MUX_GEN
        assign out = in[i] & (sel == i);
    end
endgenerate

endmodule
