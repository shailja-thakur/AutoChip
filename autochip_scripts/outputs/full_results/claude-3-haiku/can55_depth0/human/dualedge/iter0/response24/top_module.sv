module top_module(
    input clk,
    input d,
    output reg q
);

// Use two flip-flops, one triggered on the positive edge and one on the negative edge
reg q_pos, q_neg;

always @(posedge clk) begin
    q_pos <= d;
end

always @(negedge clk) begin
    q_neg <= d;
end

// Combine the outputs of the two flip-flops to create the dual-edge triggered behavior
always @(posedge clk or negedge clk) begin
    if (clk) begin
        q <= q_pos;
    end else begin
        q <= q_neg;
    end
end

endmodule
