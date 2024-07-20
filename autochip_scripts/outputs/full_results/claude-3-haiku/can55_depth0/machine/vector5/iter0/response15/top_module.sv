module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] inv_abcde, direct_abcde;

    // Create the two 25-bit vectors
    assign inv_abcde = {5{~a}, 5{~b}, 5{~c}, 5{~d}, 5{~e}};
    assign direct_abcde = {5{a,b,c,d,e}};

    // Compute the bitwise exclusive-or
    assign out = inv_abcde ^ direct_abcde;

endmodule
