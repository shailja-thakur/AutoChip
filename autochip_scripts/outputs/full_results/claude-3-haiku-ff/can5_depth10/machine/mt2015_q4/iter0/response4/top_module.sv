module top_module(
    input x,
    input y,
    output z
);

wire a_out, b_out;

and_gate first_gate (
    .a(x),
    .b(y),
    .out(a_out)
);

and_gate second_gate (
    .a(y),
    .b(x),
    .out(b_out)
);

and_gate third_gate (
    .a(a_out),
    .b(b_out),
    .out(z)
);

endmodule
module and_gate(
    input a,
    input b,
    output out
);

assign out = a & b;

endmodule
