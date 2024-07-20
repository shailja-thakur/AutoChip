module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire a_or_b, c_or_d;

// Implement the bitwise OR of inputs a and b
assign a_or_b = a | b;

// Implement the bitwise OR of inputs c and d
assign c_or_d = c | d;

// Implement the bitwise AND of the two ORs
assign q = a_or_b & c_or_d;

endmodule
