module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    // Construct the first vector by repeating each input signal 5 times and then inverting the result
    wire [24:0] vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    
    // Construct the second vector by repeating the concatenation of the input signals 5 times
    wire [24:0] vector2 = {5{a, b, c, d, e}};
    
    // Perform bitwise exclusive-or of the two vectors
    assign out = vector1 ^ vector2;
endmodule
