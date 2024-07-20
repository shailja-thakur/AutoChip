module top_module(
    input [1:0] A,
    input [1:0] B,
    output z);
    
    assign z = (A[0] == B[0]) && (A[1] == B[1]);

endmodule
