module top_module(
    input a, 
    input b,
    output out
);

    // Implement the logic gate using the given description
    assign out = ~(a | b);

endmodule
