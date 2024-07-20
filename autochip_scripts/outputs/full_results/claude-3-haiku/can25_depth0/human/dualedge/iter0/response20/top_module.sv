module top_module(
    input clk,
    input d,
    output reg q
);

// Create two instances of a single-edge triggered flip-flop
reg q_pos, q_neg;

// Positive-edge triggered flip-flop
always @(posedge clk) begin
    q_pos <= d;
end

// Negative-edge triggered flip-flop
always @(negedge clk) begin
    q_neg <= d;
end

// Combine the outputs of the two flip-flops to get a dual-edge behavior
always @(posedge clk or negedge clk) begin
    q <= (q_pos & q_neg);
end

endmodule
