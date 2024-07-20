module top_module (
    input clk,
    input x,
    output z
);
    reg q1, q2, q3;

    // D flip-flop for XOR gate
    always @(posedge clk) begin
        q1 <= x ^ q1;
    end

    // D flip-flop for AND gate
    always @(posedge clk) begin
        q2 <= x & ~q2;
    end

    // D flip-flop for OR gate
    always @(posedge clk) begin
        q3 <= x | ~q3;
    end

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
