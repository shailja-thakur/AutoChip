module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    // Form the first 25-bit vector ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
    wire [24:0] first_vector = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    
    // Form the second 25-bit vector {5{a, b, c, d, e}}
    wire [24:0] second_vector = {5{a, b, c, d, e}};
    
    // Compute the bitwise exclusive-or of the first and second vectors
    assign out = first_vector ^ second_vector;
endmodule
