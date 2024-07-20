module top_module(
    input clk,
    input d,
    output reg q);

    reg q_pos, q_neg;

    // Positive edge triggered flip-flop
    always @(posedge clk) begin
        q_pos <= d;
    end

    // Negative edge triggered flip-flop
    always @(negedge clk) begin
        q_neg <= d;
    end

    // Combine outputs of pos and neg edge flip-flops
    always @(posedge clk or negedge clk) begin
        q <= clk ? q_neg : q_pos;
    end

endmodule
