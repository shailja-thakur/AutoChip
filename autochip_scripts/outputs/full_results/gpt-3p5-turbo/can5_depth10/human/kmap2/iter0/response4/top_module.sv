module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

// Define internal wires for convenience
wire w1, w2, w3;

// Implement the Karnaugh map equations
assign w1 = a & b;
assign w2 = (c & d) | (a & !b);
assign w3 = (!c & d) | (a & b) | (!a & !b & c);

// Output is the OR of the internal wires
assign out = w1 | w2 | w3;

endmodule
