module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    genvar i;
    generate
        // Calculate out_both
        for (i = 0; i < 99; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i+1] & in[i];
        end

        // Calculate out_any
        for (i = 1; i < 100; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i-1];
        end

        // Calculate out_different
        for (i = 1; i < 100; i = i + 1) begin : gen_out_different
            assign out_different[i] = in[i] ^ in[i-1];
        end
        assign out_different[0] = in[0] ^ in[99];
    endgenerate

endmodule
