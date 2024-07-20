module top_module(
    input clk,
    input d,
    output reg q);

    reg q1, q2;

    // Positive edge triggered flip-flop
    always @(posedge clk) begin
        q1 <= d;
    end

    // Negative edge triggered flip-flop
    always @(negedge clk) begin
        q2 <= d;
    end

    // Combination of both edges
    always @(*) begin
        q = clk ? q1 : q2;
    end

endmodule
