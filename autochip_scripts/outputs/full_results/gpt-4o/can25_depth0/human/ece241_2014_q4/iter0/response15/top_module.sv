module top_module (
    input clk,
    input x,
    output z
);
    // Declare the flip-flop outputs
    reg dff1_q, dff2_q, dff3_q;

    // Synchronous process for D flip-flops
    always @(posedge clk) begin
        dff1_q <= x ^ dff1_q;                   // D flip-flop 1
        dff2_q <= x & (~dff2_q);                // D flip-flop 2
        dff3_q <= x | (~dff3_q);                // D flip-flop 3
    end

    // XNOR of the flip-flop outputs
    assign z = ~(dff1_q ^ dff2_q ^ dff3_q);

endmodule
