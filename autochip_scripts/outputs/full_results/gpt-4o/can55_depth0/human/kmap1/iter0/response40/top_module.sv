module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Using the Karnaugh map, we derive the SOP (Sum of Products) expression:
    // out = (!a & b & !c) | (!a & b & c) | (a & b & c) | (!a & !b & c) | (!a & !b & !c) | (!a & !b & c) | (a & b & !c)
    // Simplified boolean algebra results in:
    // out = b | (!a & c)

    assign out = b | (~a & c);

endmodule
