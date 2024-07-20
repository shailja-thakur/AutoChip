module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    genvar i;

    // Generate out_both: each bit indicates if both the corresponding bit and its left neighbor are 1
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i+1] & in[i];
        end
    endgenerate

    // Generate out_any: each bit indicates if either the corresponding bit or its right neighbor is 1
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different: each bit indicates if the corresponding bit is different from its left neighbor (wrap around)
    assign out_different[99] = in[99] ^ in[0]; // Special case for wrap around
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_different
            assign out_different[i] = in[i] ^ in[i+1];
        end
    endgenerate
endmodule
