module top_module (
    input clk,
    input x,
    output z
);
    reg q1, q2, q3;
    wire q1_next, q2_next, q3_next;

    assign q1_next = x ^ q1;           // XOR gate
    assign q2_next = x & ~q2;          // AND gate with complemented output of flip-flop
    assign q3_next = x | ~q3;          // OR gate with complemented output of flip-flop

    // D Flip-Flops with clock
    always @(posedge clk) begin
        q1 <= q1_next;
        q2 <= q2_next;
        q3 <= q3_next;
    end

    // XNOR of the flip-flop outputs
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
