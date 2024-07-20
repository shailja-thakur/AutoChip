module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire or1;
    wire or2;

    assign or1 = a | b; // Bitwise OR of inputs a and b
    assign or2 = c | d; // Bitwise OR of inputs c and d

    assign q = or1 & or2; // Bitwise AND of the two ORs

endmodule
