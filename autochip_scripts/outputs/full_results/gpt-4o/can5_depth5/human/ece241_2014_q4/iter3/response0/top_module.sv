module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;

    // Initial values for the D flip-flops
    initial begin
        q1 = 0;
        q2 = 0;
        q3 = 0;
    end

    // D flip-flops
    always @(posedge clk) begin
        q1 <= x ^ q1;
        q2 <= x & ~q2;
        q3 <= x | ~q3;
    end

    // XNOR gate with inputs q1, q2, q3
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
