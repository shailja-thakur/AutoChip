module top_module(
    input [1:0] A,
    input [1:0] B,
    output z);

    // Compare the two inputs A and B
    assign z = (A == B);

endmodule
