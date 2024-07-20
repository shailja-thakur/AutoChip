module top_module(
    input x,
    input y,
    output z
);

wire a;
wire b;

// First gate
and_gate and1(
    .a(x),
    .b(y),
    .o(a)
);

// Second gate
and_gate and2(
    .a(y),
    .b(x),
    .o(b)
);

// Third gate
and_gate and3(
    .a(a),
    .b(b),
    .o(z)
);


endmodule
module and_gate(
    input a,
    input b,
    output o
);
    assign o = a & b;
endmodule
