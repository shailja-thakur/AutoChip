module top_module(
    input clk,
    input d,
    output reg q
);
    reg q1, q2;

    // Flip-flop on the positive edge of the clock
    always @(posedge clk) begin
        q1 <= d;
    end

    // Flip-flop on the negative edge of the clock
    always @(negedge clk) begin
        q2 <= d;
    end

    // Combine the outputs of both flip-flops
    always @* begin
        q = clk ? q1 : q2;
    end

endmodule
