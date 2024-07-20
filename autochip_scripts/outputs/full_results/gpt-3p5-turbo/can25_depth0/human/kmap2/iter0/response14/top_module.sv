module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

// Implement the truth table for the Karnaugh map
assign out = (~a & ~c) | (~b & ~c) | (a & b & ~d) | (a & ~b & c) | (~b & d); 

endmodule
