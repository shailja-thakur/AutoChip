module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;
    wire a1, b1, a2, b2;

    assign a1 = x;
    assign b1 = y;
    assign a2 = y;
    assign b2 = x;

    and u1(out1, a1, b1);
    or u2(out2, a2, b2);

    xor u3(z, out1, out2);

endmodule
