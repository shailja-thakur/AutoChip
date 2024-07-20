module top_module(
    input a,
    input b,
    output out
);

    // Implement the logic to produce the desired output
    assign out = ~(a | b);

endmodule
