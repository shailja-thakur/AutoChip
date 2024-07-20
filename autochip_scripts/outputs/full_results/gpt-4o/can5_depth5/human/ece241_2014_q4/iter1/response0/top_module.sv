module top_module (
    input clk,
    input x,
    output reg z
);

    reg q1, q2, q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= x ^ q1;
        q2 <= x & ~q2;
        q3 <= x | ~q3;
    end

    // XNOR gate with inputs q1, q2, q3
    always @(*) begin
        z = ~(q1 ^ q2 ^ q3);
    end

endmodule
