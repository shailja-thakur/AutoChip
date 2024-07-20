module top_module(
    input a, 
    input b,
    output out
);

    // Implement the XNOR gate logic
    assign out = ~(a ^ b);

endmodule
