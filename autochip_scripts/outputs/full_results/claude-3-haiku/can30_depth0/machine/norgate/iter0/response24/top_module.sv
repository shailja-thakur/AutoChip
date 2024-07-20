module top_module(
    input a, 
    input b,
    output out
);

    // Implement the logic gate
    assign out = ~(a | b);

endmodule
