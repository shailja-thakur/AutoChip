module top_module(
    input clk,
    input d,
    output reg q
);

reg q_pos, q_neg;

// Positive edge-triggered flip-flop
always @(posedge clk) begin
    q_pos <= d;
end

// Negative edge-triggered flip-flop
always @(negedge clk) begin
    q_neg <= d;
end

// Combine the positive and negative edge-triggered flip-flops
always @(posedge clk or negedge clk) begin
    q <= (q_pos & clk) | (q_neg & ~clk);
end

endmodule
