module top_module(
    input a, 
    input b,
    output out
);

    assign out = ~(a ^ b);  // XNOR operation: out is 1 when a and b are the same

endmodule
