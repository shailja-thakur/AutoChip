module top_module(
    input [1:0] A,
    input [1:0] B,
    output z
);
    // Compare the two 2-bit inputs bit-by-bit and assign the result to z
    assign z = (A == B) ? 1'b1 : 1'b0;
endmodule
