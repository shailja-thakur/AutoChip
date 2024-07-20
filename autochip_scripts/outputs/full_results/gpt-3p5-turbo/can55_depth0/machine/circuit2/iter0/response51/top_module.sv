module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire w1, w2, w3;
    
    // Bitwise XOR of inputs a and b
    assign w1 = a ^ b;
    // Bitwise XOR of inputs c and d
    assign w2 = c ^ d;
    // Bitwise XOR of w1 and w2
    assign w3 = w1 ^ w2;
    // Inverting the output
    assign q = ~w3;

endmodule
