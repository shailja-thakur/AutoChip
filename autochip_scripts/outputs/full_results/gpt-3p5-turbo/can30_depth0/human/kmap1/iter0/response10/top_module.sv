module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Use AND gates to implement the Karnaugh map
    wire term1 = a & b & c;
    wire term2 = a & b & !c;
    wire term3 = a | b | c;

    // Use OR gates to combine the terms
    assign out = term1 | term2 | term3;

endmodule
