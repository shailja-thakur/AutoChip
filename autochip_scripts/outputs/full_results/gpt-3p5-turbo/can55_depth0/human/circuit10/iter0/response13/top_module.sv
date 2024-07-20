module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg q_reg;
reg state_reg;
always @(posedge clk) begin
    state_reg <= a & b;
    q_reg <= state_reg;
end

assign q = q_reg;
assign state = state_reg;

endmodule
