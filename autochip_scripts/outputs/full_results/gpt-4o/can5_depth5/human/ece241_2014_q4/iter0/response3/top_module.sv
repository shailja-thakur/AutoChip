module top_module (
    input clk,
    input x,
    output z
);

    // Internal signals for the flip-flop outputs
    reg q1, q2, q3;
    
    // Complementary signals for flip-flop outputs
    wire nq1 = ~q1;
    wire nq2 = ~q2;
    wire nq3 = ~q3;

    // Gates before the D flip-flops
    wire xor_in = x ^ q1;
    wire and_in = x & nq2;
    wire or_in = x | nq3;

    // D flip-flops driven by clock
    always @(posedge clk) begin
        q1 <= xor_in;
        q2 <= and_in;
        q3 <= or_in;
    end

    // XNOR gate connected to flip-flop outputs
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
