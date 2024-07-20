module top_module(
    input a, 
    input b,
    input c,
    output out
);
    // Karnaugh map simplification indicates that the output is 1 when a is 1 or when "bc" is "01" or "11" or "10".
    assign out = a | (b & c) | (~b & c) | (b & ~c);

endmodule
