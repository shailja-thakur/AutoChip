module A (
    input x,
    input y,
    output z
);

    assign z = (x ^ y) & x;

endmodule
module B (
    input x,
    input y,
    output z
);

    assign z = (x & ~y) | (~x & y);

endmodule
module top_module (
    input x,
    input y,
    output z
);

    A A1 (x, y, z1);
    A A2 (x, y, z2);
    B B1 (x, y, z3);
    B B2 (x, y, z4);

    wire or_out;
    assign or_out = z1 | z3;

    wire and_out;
    assign and_out = z2 & z4;

    assign z = or_out ^ and_out;

endmodule
