module top_module(
    input clk,
    input d,
    output reg q
);

reg d_reg, q_neg;

always @(posedge clk) begin
    d_reg <= d;
    q <= q_neg;
end

always @(negedge clk) begin
    q_neg <= d_reg;
end

endmodule
