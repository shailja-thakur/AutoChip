module top_module(
    input [1:0] A,
    input [1:0] B,
    output z);

    // Compare A and B bit by bit
    assign z = (A == B) ? 1 : 0;

endmodule
