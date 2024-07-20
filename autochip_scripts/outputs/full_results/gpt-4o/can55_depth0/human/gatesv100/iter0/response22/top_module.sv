module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Generate out_both
    generate
        genvar i;
        for (i = 0; i < 99; i = i + 1) begin
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any
    generate
        for (i = 1; i < 100; i = i + 1) begin
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different with wrapping around
    assign out_different[0] = in[0] ^ in[99]; // Wrapping case
    generate
        for (i = 1; i < 100; i = i + 1) begin
            assign out_different[i] = in[i] ^ in[i-1];
        end
    endgenerate

endmodule
