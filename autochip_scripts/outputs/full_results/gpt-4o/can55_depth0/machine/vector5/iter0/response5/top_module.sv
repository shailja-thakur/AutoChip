module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // Generate the first 25-bit vector with ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
    wire [24:0] first_vector;
    assign first_vector = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Generate the second 25-bit vector with {5{a,b,c,d,e}}
    wire [24:0] second_vector;
    assign second_vector = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Compute bitwise exclusive-or of the two vectors
    assign out = first_vector ^ second_vector;

endmodule
