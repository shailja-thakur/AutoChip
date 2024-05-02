module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    // assign out = ~{ ... } ^ { ... };
    // Insert your code below

    assign out = ~{a, a, a, a, a, b, b, b, b, b, c, c, c, c, c, d, d, d, d, d, e, e, e, e, e};
    // The above code creates a vector of 25 bits, with each bit being the complement of the corresponding bit in the input vector.
    // The XNOR operation then compares each bit in the input vector to its complement, and outputs a 1 if the bits are equal.
endmodule