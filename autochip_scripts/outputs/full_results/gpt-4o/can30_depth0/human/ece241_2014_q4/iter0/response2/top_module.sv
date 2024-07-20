module top_module (
    input clk,
    input x,
    output z
);
    wire q0, q1, q2;  // Outputs of the flip-flops
    wire q0_bar, q1_bar, q2_bar; // Complemented outputs of the flip-flops
    wire d0, d1, d2;  // Inputs to the flip-flops

    // Flip-flops
    always @(posedge clk) begin
        q0 <= d0;
        q1 <= d1;
        q2 <= d2;
    end

    // Complemented outputs of the flip-flops
    assign q0_bar = ~q0;
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;

    // Inputs to the flip-flops
    assign d0 = x ^ q0;     // XOR gate
    assign d1 = x & q1_bar; // AND gate
    assign d2 = x | q2_bar; // OR gate

    // Three-input XNOR gate
    assign z = ~(q0 ^ q1 ^ q2);

endmodule
