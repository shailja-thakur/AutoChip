module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire[6:1] y_bits;
    assign y_bits = y; // breaking y into individual bits

    assign Y2 = y_bits[1] & ~w; // generating Y2

    assign Y4 = y_bits[6] & y_bits[5] & y_bits[3] & y_bits[2] & w; // generating Y4

endmodule
