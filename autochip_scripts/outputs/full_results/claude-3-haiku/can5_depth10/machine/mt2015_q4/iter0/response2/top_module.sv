module top_module(
    input x,
    input y,
    output z
);

    wire a_out, b_out;

    gate1 u1 (
        .a(x),
        .b(y),
        .out(a_out)
    );

    gate2 u2 (
        .a(y),
        .b(x),
        .out(b_out)
    );

    gate3 u3 (
        .a(a_out),
        .b(b_out),
        .out(z)
    );

endmodule
module gate1(
    input a,
    input b,
    output out
);
    // Insert logic for gate1 here
    assign out = a & b;
endmodule
module gate2(
    input a,
    input b,
    output out
);
    // Insert logic for gate2 here
    assign out = a | b;
endmodule
module gate3(
    input a,
    input b,
    output out
);
    // Insert logic for gate3 here
    assign out = a ^ b;
endmodule
