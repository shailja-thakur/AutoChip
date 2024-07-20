module top_module (
    input clk,
    input x,
    output z
);
    reg dff1_q, dff2_q, dff3_q;

    // Flip-flops
    always @(posedge clk) begin
        dff1_q <= x ^ dff1_q;    // XOR gate
        dff2_q <= x & ~dff1_q;   // AND gate
        dff3_q <= x | ~dff2_q;   // OR gate
    end

    // XNOR of the outputs of the D flip-flops
    assign z = ~(dff1_q ^ dff2_q ^ dff3_q);

endmodule
