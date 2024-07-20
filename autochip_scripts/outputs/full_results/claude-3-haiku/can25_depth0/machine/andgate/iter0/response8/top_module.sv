module top_module(
    input a,
    input b,
    output out
);

// Connect the two input signals 'a' and 'b' to a logical AND gate
// and assign the result to the output signal 'out'
assign out = a & b;

endmodule
