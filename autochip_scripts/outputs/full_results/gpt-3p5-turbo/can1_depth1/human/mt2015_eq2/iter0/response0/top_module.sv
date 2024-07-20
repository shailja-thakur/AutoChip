module top_module(
    input [1:0] A,
    input [1:0] B,
    output z);

    // Declare internal wire for comparison
    wire equal;

    // Compare A and B
    assign equal = (A == B);

    // Assign z based on the comparison result
    assign z = equal ? 1'b1 : 1'b0;

endmodule
