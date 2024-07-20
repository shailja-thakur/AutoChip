module top_module(
    input x,
    input y,
    output z);

    wire a, b;

    // First gate
    and_gate and1(
        .a(x),
        .b(y),
        .out(a)
    );

    // Second gate
    and_gate and2(
        .a(y),
        .b(x),
        .out(b)
    );

    // Third gate
    and_gate and3(
        .a(a),
        .b(b),
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
