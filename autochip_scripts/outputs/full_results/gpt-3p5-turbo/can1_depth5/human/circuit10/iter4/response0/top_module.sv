module top_module (
    input wire clk,
    input wire a,
    input wire b,
    output reg q,
    output reg state
);

reg q_reg;
reg state_reg;

always @(posedge clk) begin
    q_reg <= a & b;
    state_reg <= (a & b) ? 1'b1 : 1'b0;
end

always @(posedge clk) begin
    q <= q_reg;
    state <= state_reg;
end

endmodule
