module top_module(
    input clk,
    input d,
    output reg q
);

// We can achieve the functionality of a dual-edge triggered flip-flop
// using two regular positive-edge triggered flip-flops.

reg q_pos, q_neg;

always @(posedge clk) begin
    q_pos <= d;
end

always @(negedge clk) begin
    q_neg <= d;
end

// We can then use a multiplexer to select the appropriate output
// based on the current clock edge.
always @(posedge clk, negedge clk) begin
    if (clk)
        q <= q_pos;
    else
        q <= q_neg;
end

endmodule
