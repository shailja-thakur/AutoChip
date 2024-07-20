module top_module (
    input clk,
    input x,
    output z
);

    // Internal signals for flip-flop outputs and complemented outputs
    reg Q1, Q2, Q3;
    wire Q1_bar, Q2_bar, Q3_bar;

    // Always block for D flip-flops, initially reset to zero
    initial begin
        Q1 = 0;
        Q2 = 0;
        Q3 = 0;
    end

    always @(posedge clk) begin
        Q1 <= x ^ Q1;       // XOR gate with D flip-flop
        Q2 <= x & ~Q2;      // AND gate with D flip-flop
        Q3 <= x | ~Q3;      // OR gate with D flip-flop
    end

    assign Q1_bar = ~Q1;
    assign Q2_bar = ~Q2;
    assign Q3_bar = ~Q3;

    // XNOR gate combining the three flip-flop outputs
    assign z = ~(Q1 ^ Q2 ^ Q3);

endmodule
