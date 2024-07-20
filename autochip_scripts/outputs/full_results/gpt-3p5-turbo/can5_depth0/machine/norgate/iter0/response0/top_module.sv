module top_module(
    input a, 
    input b,
    output out
);

    wire or_output;
    wire neg_output;

    // OR gate
    or_gate or1 (
        .a(a),
        .b(b),
        .out(or_output)
    );

    // Inverter
    inv_gate inv1 (
        .in(or_output),
        .out(neg_output)
    );

    // Assign the output
    assign out = neg_output;

endmodule
module or_gate(
    input a,
    input b,
    output out
);

    assign out = a | b;

endmodule
module inv_gate(
    input in,
    output out
);

    assign out = ~in;

endmodule
