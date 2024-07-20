module top_module (
	input [31:0] in,
	output [31:0] out
);

    // Instantiate the byte reverse module
    byte_reverse_module reverse_module (
        .in(in),
        .out(out)
    );

endmodule
module byte_reverse_module (
    input [31:0] in,
    output [31:0] out
);

    genvar i;

    generate
        for (i=0; i<4; i=i+1) begin : reverse_loop
            assign out[i*8 +: 8] = in[31 - i*8 -: 8];
        end
    endgenerate

endmodule
