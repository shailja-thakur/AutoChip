module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3;

    // D flip-flop inputs
    wire d1_next = x ^ d1;
    wire d2_next = x & ~d2;
    wire d3_next = x | ~d3;

    // D flip-flop instantiation
    always @(posedge clk) begin
        d1 <= d1_next;
        d2 <= d2_next;
        d3 <= d3_next;
    end

    // XNOR gate combining outputs of D flip-flops
    assign z = ~(d1 ^ d2 ^ d3);

endmodule
