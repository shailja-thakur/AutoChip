module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [24:0] not_vector, and_vector;

// Create the first 25-bit vector
assign not_vector = {5{~a}, 5{~b}, 5{~c}, 5{~d}, 5{~e}};

// Create the second 25-bit vector
assign and_vector = {5{a,b,c,d,e}};

// Compute the bitwise XOR of the two 25-bit vectors
assign out = not_vector ^ and_vector;

endmodule
