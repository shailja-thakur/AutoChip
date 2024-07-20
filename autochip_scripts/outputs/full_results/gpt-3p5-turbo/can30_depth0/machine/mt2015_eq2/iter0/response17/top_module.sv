module top_module(
    input [1:0] A,
    input [1:0] B,
    output z);

    //  logic for comparing the bits of A and B
    assign z = (A[1] == B[1] && A[0] == B[0]);

endmodule
