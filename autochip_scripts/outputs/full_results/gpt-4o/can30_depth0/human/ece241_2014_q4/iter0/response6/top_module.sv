module top_module (
    input clk,
    input x,
    output z
);
    // Internal wires and registers
    wire q1, q2, q3;      // Flip-flop outputs
    wire nq1, nq2, nq3;   // Complement of flip-flop outputs
    wire d1, d2, d3;      // D flip-flop inputs

    // Three D flip-flops
    reg q1_reg, q2_reg, q3_reg; // D flip-flops

    // Outputs of the flip-flops
    assign q1 = q1_reg;
    assign q2 = q2_reg;
    assign q3 = q3_reg;

    // Complement of the flip-flop outputs
    assign nq1 = ~q1;
    assign nq2 = ~q2;
    assign nq3 = ~q3;

    // D flip-flop input logic
    assign d1 = x ^ q1;
    assign d2 = x & nq2;
    assign d3 = x | nq3;

    // D flip-flops with synchronous reset
    always @(posedge clk) begin
        q1_reg <= d1;
        q2_reg <= d2;
        q3_reg <= d3;
    end

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
