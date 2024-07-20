module top_module(
    input a, 
    input b,
    input c,
    output out
);

// Intermediate wires
wire w1, w2, w3;

// Implementing the logic gates based on the Karnaugh map
assign w1 = ~a & ~b;
assign w2 = b | ~c;
assign w3 = w2 & (a | c);

// Output assignment
assign out = w1 | w3;

endmodule
