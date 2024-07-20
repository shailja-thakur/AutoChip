module top_module (
    input clk,
    input x,
    output z
);

    // Intermediate signals
    wire d1, d2, d3;
    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // D flip-flops
    reg q1_reg, q2_reg, q3_reg;
    always @(posedge clk) begin
        q1_reg <= d1;
        q2_reg <= d2;
        q3_reg <= d3;
    end

    // Assigning the flip-flop outputs to the intermediate wires
    assign q1 = q1_reg;
    assign q2 = q2_reg;
    assign q3 = q3_reg;

    // Complemented outputs of the flip-flops
    assign nq1 = ~q1;
    assign nq2 = ~q2;
    assign nq3 = ~q3;

    // Logic gates with input x and respective flip-flop outputs
    assign d1 = x ^ q1;    // XOR gate
    assign d2 = x & nq2;   // AND gate
    assign d3 = x | nq3;   // OR gate

    // Output z as a three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
