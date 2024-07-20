module top_module(
    input [1:0] A,
    input [1:0] B,
    output z);

    // Compare the two 2-bit inputs A and B bit-by-bit
    assign z = (A == B);

endmodule
