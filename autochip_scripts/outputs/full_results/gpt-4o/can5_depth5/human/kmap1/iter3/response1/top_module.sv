module top_module(
    input a, 
    input b,
    input c,
    output out
);
    // Create the Boolean expression from the Karnaugh map
    assign out = (~a & b) | (~b & c) | (a & b);
endmodule
