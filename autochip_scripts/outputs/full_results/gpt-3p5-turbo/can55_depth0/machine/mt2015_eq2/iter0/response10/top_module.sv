module top_module(
    input [1:0] A,
    input [1:0] B,
    output reg z
);

    // Correction: Add always block to compare the inputs bit-by-bit
    always @(*) begin
        // Comparison logic
        if (A[1] == B[1] && A[0] == B[0]) begin
            z = 1;
        end
        else begin
            z = 0;
        end
    end

endmodule
