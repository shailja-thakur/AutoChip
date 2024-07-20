module top_module (
    input clk,
    input x,
    output reg z
);

    reg d1, d2, d3; // Internal D flip-flop states

    // D flip-flops behavior
    always @(posedge clk) begin
        d1 <= x ^ d1;
        d2 <= x & ~d2;
        d3 <= x | ~d3;
    end

    // XNOR gate with inputs d1, d2, d3
    always @(*) begin
        z = ~(d1 ^ d2 ^ d3);
    end

endmodule
