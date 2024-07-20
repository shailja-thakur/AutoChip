module top_module (
    input clk,
    input x,
    output z
);
    // Inputs to D flip-flops
    wire d1, d2, d3;
    
    // Outputs from D flip-flops
    reg q1, q2, q3;
    
    // Complementary outputs from D flip-flops
    wire q1_bar, q2_bar, q3_bar;

    // Assign complementary outputs
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;

    // Logic for D flip-flop inputs
    assign d1 = x ^ q1;        // XOR gate
    assign d2 = x & q2_bar;    // AND gate
    assign d3 = x | q3_bar;    // OR gate

    // D flip-flops with synchronous reset
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Three-input XNOR gate for output z
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
