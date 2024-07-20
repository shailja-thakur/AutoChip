module top_module(
    input a,
    input b,
    output out
);

    // Instantiate NOR gate
    assign out = ~(a | b);

endmodule
