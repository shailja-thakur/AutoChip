module top_module (
    input clk,
    input x,
    output z
);
    reg q1, q2, q3; // D flip-flops

    wire xor_out, and_out, or_out;
    wire q2_not, q3_not;

    // Complemented outputs of Q2 and Q3
    assign q2_not = ~q2;
    assign q3_not = ~q3;

    // XOR, AND, OR gates
    assign xor_out = x ^ q1;
    assign and_out = x & q2_not;
    assign or_out = x | q3_not;

    // D flip-flops update on clock edge
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // XNOR gate combining all flip-flop outputs
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
