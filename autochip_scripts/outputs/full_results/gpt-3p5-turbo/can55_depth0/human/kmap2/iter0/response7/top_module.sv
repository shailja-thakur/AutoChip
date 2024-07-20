module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire w1, w2, w3;

// Implementing the Karnaugh map circuit
assign w1 = (a & b & c) | (a & c & d);
assign w2 = d & (a | b);
assign w3 = (~a & b & ~c) | (a & b & ~c);

assign out = w1 | w2 | w3;

endmodule
