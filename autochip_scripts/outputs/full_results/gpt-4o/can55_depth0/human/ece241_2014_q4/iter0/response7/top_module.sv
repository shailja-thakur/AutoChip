module top_module (
    input clk,
    input x,
    output z
);
    // Declare flip-flop outputs
    reg q1, q2, q3;

    // Intermediate net for complemented outputs of flip-flops
    wire nq1 = ~q1;
    wire nq2 = ~q2;
    wire nq3 = ~q3;

    // Intermediate net for gate outputs
    wire xor_out = x ^ q1;
    wire and_out = x & nq2;
    wire or_out = x | nq3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // XNOR to compute final output
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
