module top_module(
    input a, 
    input b,
    input c,
    output out
);

// defining intermediate wires for implementing the Karnaugh map
wire d;

// implementing the logic using the Karnaugh map
assign d = (~a & b) | (a & b & c);

// assigning the output
assign out = d;

endmodule
