module top_module (
    input clk,
    input x,
    output z
);

    wire xd, xd_bar, xand, xor, dff1_q, dff2_q, dff3_q;

    // D Flip-flop 1
    dff dff1 (
        .clk(clk),
        .d(xor),
        .q(dff1_q)
    );

    // D Flip-flop 2
    dff dff2 (
        .clk(clk),
        .d(xand),
        .q(dff2_q)
    );

    // D Flip-flop 3
    dff dff3 (
        .clk(clk),
        .d(xd),
        .q(dff3_q)
    );

    // XOR gate
    assign xor = x ^ dff1_q;

    // AND gate
    assign xand = x & ~dff2_q;

    // OR gate
    assign xd = x | ~dff3_q;

    // XNOR gate
    assign z = ~(dff1_q ^ dff2_q ^ dff3_q);

endmodule
module dff (
    input clk,
    input d,
    output reg q
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule
