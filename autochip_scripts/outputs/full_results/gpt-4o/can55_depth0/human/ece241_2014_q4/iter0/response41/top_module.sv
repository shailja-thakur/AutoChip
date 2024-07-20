module top_module (
    input clk,
    input x,
    output z
);

    // D Flip-Flops
    reg q1, q2, q3;
    wire d1, d2, d3;

    // Combinational Logic for Flip-Flop Inputs
    assign d1 = x ^ q1;
    assign d2 = x & ~q2;
    assign d3 = x | ~q3;

    // Flip-Flops Updating on Clock Edge
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Output Logic
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
