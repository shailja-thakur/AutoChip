module a (
    input x,
    input y,
    output z
);

    assign z = (x ^ y) & x;

endmodule
module b (
    input x,
    input y,
    output z
);

    assign #5 z = (x ^ y) & x;

endmodule
module and_gate (
    input a,
    input b,
    output z
);

    assign z = a & b;

endmodule
module or_gate (
    input a,
    input b,
    output z
);

    assign z = a | b;

endmodule
module xor_gate (
    input a,
    input b,
    output z
);

    assign z = a ^ b;

endmodule
module top_module (
    input x,
    input y,
    output z
);

    wire a_out_1, a_out_2, b_out_1, b_out_2;
    wire or_out, and_out;

    a a1 (.x(x), .y(y), .z(a_out_1));
    a a2 (.x(x), .y(y), .z(a_out_2));
    b b1 (.x(x), .y(y), .z(b_out_1));
    b b2 (.x(x), .y(y), .z(b_out_2));

    or_gate or1 (.a(a_out_1), .b(b_out_1), .z(or_out));
    and_gate and1 (.a(a_out_2), .b(b_out_2), .z(and_out));
    xor_gate xor1 (.a(or_out), .b(and_out), .z(z));

endmodule
