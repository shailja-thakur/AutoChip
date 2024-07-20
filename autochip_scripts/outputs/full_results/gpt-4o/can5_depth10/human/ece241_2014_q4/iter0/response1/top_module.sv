module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire d1, d2, d3;
    
    // D flip-flops
    reg q1_reg, q2_reg, q3_reg;
    
    // D inputs
    assign d1 = x ^ q1_reg;
    assign d2 = x & ~q2_reg;
    assign d3 = x | ~q3_reg;

    // Flip-flop outputs
    always @(posedge clk) begin
        q1_reg <= d1;
        q2_reg <= d2;
        q3_reg <= d3;
    end

    // Assign flip-flop outputs to wires for XNOR gate
    assign q1 = q1_reg;
    assign q2 = q2_reg;
    assign q3 = q3_reg;

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
