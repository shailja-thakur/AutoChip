module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // Create the inverted vector
    wire [24:0] inv_vector = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    
    // Create the original vector
    wire [24:0] orig_vector = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    
    // Compute the bitwise exclusive-or
    assign out = inv_vector ^ orig_vector;

endmodule
