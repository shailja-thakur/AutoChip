module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    and gate1(.a(a), .b(x), .c(y));
    or gate2(.a(b), .b(y), .c(x));
    or gate3(.a(z), .b(a), .c(b));

endmodule
