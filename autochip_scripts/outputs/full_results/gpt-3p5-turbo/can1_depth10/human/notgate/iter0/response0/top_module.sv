module top_module(
    input in,
    output out
);
    // Combinational logic to implement a NOT gate
    not_gate not1(
        .in(in),
        .out(out)
    );

endmodule
module not_gate(
    input in,
    output out
);
    assign out = ~in; // Use the bitwise negation operator to implement the NOT gate

endmodule
