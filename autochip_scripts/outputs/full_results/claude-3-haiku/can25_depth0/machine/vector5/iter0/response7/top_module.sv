module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [24:0] vec1, vec2;

// Construct the first 25-bit vector
assign vec1 = ~{5{a}, 5{b}, 5{c}, 5{d}, 5{e}};

// Construct the second 25-bit vector
assign vec2 = {5{a,b,c,d,e}};

// Compute the bitwise exclusive-or of the two vectors
assign out = vec1 ^ vec2;

endmodule
