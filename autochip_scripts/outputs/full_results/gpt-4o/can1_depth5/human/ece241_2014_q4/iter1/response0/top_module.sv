module top_module (
    input clk,
    input x,
    output reg z
);
    reg dff1_q, dff2_q, dff3_q;

    // Flip-flops
    always @(posedge clk) begin
        dff1_q <= x ^ dff1_q;   // XOR gate
        dff2_q <= x & ~dff2_q;  // AND gate
        dff3_q <= x | ~dff3_q;  // OR gate
    end

    // XNOR of the outputs of the D flip-flops
    always @(posedge clk) begin
        z <= ~(dff1_q ^ dff2_q ^ dff3_q);
    end

endmodule
