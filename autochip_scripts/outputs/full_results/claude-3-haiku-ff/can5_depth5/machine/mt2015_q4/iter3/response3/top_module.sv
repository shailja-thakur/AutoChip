module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    assign a1 = x;
    assign b1 = y;
    and gate1(out1, a1, b1);

    assign a2 = y; 
    assign b2 = x;
    and gate2(out2, a2, b2);

    or gate3(z, out1, out2);

endmodule
