module top_module(
    input [1:0] A,
    input [1:0] B,
    output z);

    // Compare the two 2-bit inputs A and B
    // If they are equal, set the output z to 1
    // Otherwise, set z to 0
    assign z = (A == B) ? 1'b1 : 1'b0;

endmodule
