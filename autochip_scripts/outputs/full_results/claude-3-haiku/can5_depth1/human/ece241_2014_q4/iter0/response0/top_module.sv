module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    wire x_xor_q1, x_and_q1_bar, x_or_q1_bar;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= x ^ q1;
        q2 <= x & ~q1;
        q3 <= x | ~q1;
    end

    // Combinational logic
    assign x_xor_q1 = x ^ q1;
    assign x_and_q1_bar = x & ~q1;
    assign x_or_q1_bar = x | ~q1;

    // Output XNOR gate
    assign z = ~(x_xor_q1 ^ x_and_q1_bar ^ x_or_q1_bar);

endmodule
