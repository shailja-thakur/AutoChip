 //Given five 1-bit signals (a, b, c, d, and e), compute all 25 pairwise one-bit comparisons 
 // in the 25-bit output vector. The output should be 1 if the two bits being compared are equal.

// Hint: out[24] = ~a ^ a;   // a == a, so out[24] is always 1.
// out[23] = ~a ^ b;
// out[22] = ~a ^ c;
// ...

module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    // assign out = ~{ ... } ^ { ... };
    // Insert your code below

endmodule