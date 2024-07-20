module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // Compute the first 25-bit vector
    wire [24:0] vec1 = {5{~a}, 5{~b}, 5{~c}, 5{~d}, 5{~e}};

    // Compute the second 25-bit vector
    wire [24:0] vec2 = {5{a, b, c, d, e}};

    // Perform the bitwise exclusive-or operation
    assign out = vec1 ^ vec2;

endmodule
