module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg q_reg;
reg state_reg;

always @(posedge clk) begin
    state_reg <= ((a & ~b) | (state_reg & ~a));
    q_reg <= b;
end

always @(posedge clk) begin
    q <= q_reg;
    state <= state_reg;
end

endmodule
