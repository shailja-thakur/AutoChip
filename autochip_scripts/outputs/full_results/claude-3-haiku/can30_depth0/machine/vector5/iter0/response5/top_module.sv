module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] not_vector;
    wire [24:0] and_vector;

    // Compute the 25-bit vector ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
    assign not_vector = {5{~a}, 5{~b}, 5{~c}, 5{~d}, 5{~e}};

    // Compute the 25-bit vector {5{a,b,c,d,e}}
    assign and_vector = {5{a, b, c, d, e}};

    // Compute the bitwise exclusive-or of the two vectors
    assign out = not_vector ^ and_vector;

endmodule
