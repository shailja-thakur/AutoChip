module top_module (
    input clk,
    input x,
    output z
);

    // Internal signals
    reg d1, d2, d3;
    wire ff1_out, ff2_out, ff3_out;
    wire xor_out, and_out, or_out;
    wire not_ff2_out, not_ff3_out;
    wire xnor_out;

    // D flip-flops
    always @(posedge clk) begin
        ff1_out <= d1;
        ff2_out <= d2;
        ff3_out <= d3;
    end

    // XOR gate with D1 flip-flop
    assign xor_out = x ^ ff1_out;
    // AND gate with NOT of D2 flip-flop output
    assign not_ff2_out = ~ff2_out;
    assign and_out = x & not_ff2_out;
    // OR gate with NOT of D3 flip-flop output
    assign not_ff3_out = ~ff3_out;
    assign or_out = x | not_ff3_out;

    // Flip-flop input assignments
    assign d1 = xor_out;
    assign d2 = and_out;
    assign d3 = or_out;

    // XNOR gate combining the flip-flop outputs
    assign xnor_out = ~(ff1_out ^ ff2_out ^ ff3_out);

    // Output assignment
    assign z = xnor_out;

endmodule
