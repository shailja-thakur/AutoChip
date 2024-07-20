module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] vector1, vector2;

    // Create the first vector, which is the bitwise negation of replicated inputs
    assign vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Create the second vector, which is the concatenation and replication of inputs
    assign vector2 = {5{a,b,c,d,e}};

    // Compute the bitwise exclusive-or of vector1 and vector2
    assign out = vector1 ^ vector2;

endmodule
