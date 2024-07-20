module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] v1, v2;

    // Generate the first 25-bit vector
    assign v1 = {5{~a}, 5{~b}, 5{~c}, 5{~d}, 5{~e}};

    // Generate the second 25-bit vector
    assign v2 = {5{a, b, c, d, e}};

    // Compute the bitwise exclusive-or
    assign out = v1 ^ v2;

endmodule
