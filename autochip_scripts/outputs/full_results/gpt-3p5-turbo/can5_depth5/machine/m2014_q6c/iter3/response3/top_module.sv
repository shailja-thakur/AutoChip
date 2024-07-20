module top_module (
    input [6:1] y,
    input w,
    output wire Y2,
    output wire Y4
);

    wire [5:0] y_bits;
    assign y_bits = y[6:1];

    assign Y2 = y[1] & ~w;
    assign Y4 = y_bits[1] & y_bits[2] & y_bits[4] & y_bits[5] & w;

endmodule
