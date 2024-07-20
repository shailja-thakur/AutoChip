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
end

always @(posedge clk) begin
    q_reg <= state_reg;
end

assign q = q_reg;
assign state = state_reg;

endmodule
