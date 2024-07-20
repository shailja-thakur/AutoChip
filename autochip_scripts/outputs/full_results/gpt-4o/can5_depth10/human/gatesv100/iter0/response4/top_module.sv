module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Compute out_both
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : both_loop
            assign out_both[i] = in[i] & in[i + 1];
        end
    endgenerate

    // Compute out_any
    generate
        for (i = 1; i < 100; i = i + 1) begin : any_loop
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate

    // Compute out_different
    generate
        for (i = 0; i < 100; i = i + 1) begin : different_loop
            if (i == 99) begin
                assign out_different[i] = in[i] ^ in[0]; // wrap around case
            end else begin
                assign out_different[i] = in[i] ^ in[i + 1];
            end
        end
    endgenerate

endmodule
