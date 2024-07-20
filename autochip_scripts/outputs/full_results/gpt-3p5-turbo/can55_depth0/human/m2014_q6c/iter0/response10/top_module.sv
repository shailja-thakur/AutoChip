module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire Y2_int, Y4_int;

    // Logic equations for Y2
    assign Y2_int = y[5] && (y[2] ^ w);

    // Logic equations for Y4
    assign Y4_int = (y[4] && y[3]) || (y[5] && y[2]);

    // Output assignments
    assign Y2 = Y2_int;
    assign Y4 = Y4_int;

endmodule
