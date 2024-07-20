module top_module(
    input a, 
    input b,
    output out
);

    // Implement the logic to compute the output
    assign out = ~(a | b);

endmodule
