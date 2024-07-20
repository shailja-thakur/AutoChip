module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // shifted input signal
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], in[99]};

    // Generate out_both
    assign out_both = in[99:1] & in[98:0];

    // Generate out_any
    assign out_any = in | in_shifted;

    // Generate out_different
    assign out_different[0] = in[0] ^ in[99];
    assign out_different[99:1] = in[99:1] ^ in[98:0];
    
endmodule
