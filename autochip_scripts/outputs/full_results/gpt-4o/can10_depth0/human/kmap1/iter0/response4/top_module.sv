module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Implement the logic derived from the Karnaugh map
    assign out = (~b & c) | a;

endmodule
