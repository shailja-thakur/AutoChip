module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [98:0] both;
    wire [99:1] any;
    wire [99:0] different;

    // Calculate out_both
    assign both[0] = in[0] & in[99];
    assign both[1:98] = in[1:98] & in[0:97];

    // Calculate out_any
    assign any[1:98] = in[0:97] | in[1:98];
    assign any[99] = in[98] | in[99];

    // Calculate out_different
    assign different[0] = in[99] ^ in[0];
    assign different[1:98] = in[0:97] ^ in[1:98];
    assign different[99] = in[99] ^ in[0];

    // Assign outputs
    assign out_both = both;
    assign out_any = any;
    assign out_different = different;

endmodule
