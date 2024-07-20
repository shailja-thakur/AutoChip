module top_module(
    input a,
    input b,
    output out
);
    // Implement the NOR gate using the logical negation of the OR gate
    assign out = ~(a | b);
endmodule
