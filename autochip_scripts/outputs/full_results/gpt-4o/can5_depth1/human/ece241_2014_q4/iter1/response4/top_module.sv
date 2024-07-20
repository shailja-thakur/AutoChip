module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    reg q1_next, q2_next, q3_next;

    // Calculate next state
    always @(*) begin
        q1_next = x ^ q1;   // XOR
        q2_next = x & ~q2;  // AND
        q3_next = x | ~q3;  // OR
    end

    // D flip-flops
    always @(posedge clk) begin
        q1 <= q1_next;
        q2 <= q2_next;
        q3 <= q3_next;
    end

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
