module top_module(
    input a,
    input b,
    output out
);

    // Implementing NOR gate using assign statement
    assign out = ~(a | b);

endmodule
