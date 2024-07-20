module top_module(
    input clk,
    input d,
    output reg q);

reg q_falling_edge;
reg q_rising_edge;

always @(posedge clk) begin
    q_falling_edge <= d;
    q_rising_edge <= q_falling_edge;
end

always @(negedge clk) begin
    q <= q_rising_edge;
end

endmodule
