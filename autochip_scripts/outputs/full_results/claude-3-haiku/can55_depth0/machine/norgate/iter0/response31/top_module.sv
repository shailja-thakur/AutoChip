module top_module(
    input a,
    input b,
    output out
);

    // The logic for the module is:
    // out = ~(a | b)
    assign out = ~(a | b);

endmodule
