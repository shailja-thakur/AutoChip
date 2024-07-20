module top_module (
    input  [15:0] in,
    output [7:0]  out_hi,
    output [7:0]  out_lo
);

    // Simply assign the upper 8 bits and lower 8 bits of the 16-bit input signal
    assign out_hi = in[15:8];
    assign out_lo = in[7:0];

endmodule
