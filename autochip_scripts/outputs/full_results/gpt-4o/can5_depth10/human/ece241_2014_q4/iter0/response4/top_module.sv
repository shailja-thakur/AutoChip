module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;

    // Always block for updating flip-flops on the positive edge of the clock
    always @(posedge clk) begin
        q1 <= x ^ q1;      // XOR with the corresponding flip-flop's output
        q2 <= x & ~q2;     // AND with the complement of the corresponding flip-flop's output
        q3 <= x | ~q3;     // OR with the complement of the corresponding flip-flop's output
    end

    // Three-input XNOR gate for the final output
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
