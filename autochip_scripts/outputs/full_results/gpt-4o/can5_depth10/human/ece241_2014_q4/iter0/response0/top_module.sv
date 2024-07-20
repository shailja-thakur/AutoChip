module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    wire d1, d2, d3;
    wire nq1, nq2, nq3;

    // Complementary outputs of flip-flops
    assign nq1 = ~q1;
    assign nq2 = ~q2;
    assign nq3 = ~q3;

    // Compute D inputs for flip-flops
    assign d1 = x ^ q1;        // XOR with the output of corresponding flip-flop
    assign d2 = x & nq2;       // AND with the complement of corresponding flip-flop's output
    assign d3 = x | nq3;       // OR with the complement of corresponding flip-flop's output

    // D flip-flop logic with reset (assume reset to zero)
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Compute the final output z using a three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
