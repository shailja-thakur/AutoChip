module top_module (
    input [4:1] x,
    output logic f
);

// Implement the function f based on the given Karnaugh map
assign f = (x[4] & x[3] & ~x[2] & ~x[1]) | (x[4] & ~x[3] & x[2] & ~x[1]) | (~x[4] & x[3] & x[2]) | (~x[4] & x[3] & ~x[1]);

endmodule
