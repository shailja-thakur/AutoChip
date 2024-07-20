module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Internal wire declarations
    wire [99:1] any_temp;
    wire [99:0] different_temp;

    // Logic for out_both
    assign out_both = in[99:1] & in[98:0];

    // Logic for out_any
    assign any_temp = in[99:0] | in[98:0];
    assign out_any = {1'b0, any_temp};

    // Logic for out_different
    assign different_temp = in[99:1] ^ in[98:0];
    assign out_different = {in[0] ^ in[99], different_temp};

endmodule
