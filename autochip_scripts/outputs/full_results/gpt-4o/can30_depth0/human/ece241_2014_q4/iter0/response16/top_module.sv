module top_module (
    input clk,
    input x,
    output z
);

    // Internal signals for flip-flop outputs
    reg dff1_q, dff2_q, dff3_q;

    // Intermediate signals for the XOR, AND, and OR gates
    wire xor_out, and_out, or_out;

    // XOR gate with D flip-flop output
    assign xor_out = x ^ dff1_q;
    // AND gate with complemented D flip-flop output
    assign and_out = x & ~dff2_q;
    // OR gate with complemented D flip-flop output
    assign or_out = x | ~dff3_q;

    // D flip-flops
    always @(posedge clk) begin
        dff1_q <= xor_out;
        dff2_q <= and_out;
        dff3_q <= or_out;
    end

    // Three-input XNOR gate to produce output z
    assign z = ~(dff1_q ^ dff2_q ^ dff3_q);

endmodule
