module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Using the Karnaugh map, the expression simplifies to: out = b + c
    assign out = b | c;

endmodule
