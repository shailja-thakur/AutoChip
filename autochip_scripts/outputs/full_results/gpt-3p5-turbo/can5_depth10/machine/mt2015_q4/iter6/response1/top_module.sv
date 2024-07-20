module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    and gate1(a, x, y);
    or gate2(b, y, x);
    or gate3(z, a, b);

endmodule
module and(
    output out,
    input in1,
    input in2
);

    assign out = in1 & in2;

endmodule
module or(
    output out,
    input in1,
    input in2
);

    assign out = in1 | in2;

endmodule
