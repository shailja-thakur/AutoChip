module top_module(
    input x,
    input y,
    output reg z);

    wire a, b;

    and gate1(a, x, y); // a = x AND y
    and gate2(b, y, x); // b = y AND x
    and gate3(z, a, b); // z = a AND b

endmodule
