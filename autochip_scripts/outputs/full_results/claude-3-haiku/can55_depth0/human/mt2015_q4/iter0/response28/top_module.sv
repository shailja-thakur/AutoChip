module top_module(
    input x,
    input y,
    output z
);

// Module A
module moduleA(
    input x,
    input y,
    output z
);
assign z = (x ^ y) & x;
endmodule
module moduleB(
    input x,
    input y,
    output z
);
assign z = ~((x & y) | (~x & ~y));
endmodule
