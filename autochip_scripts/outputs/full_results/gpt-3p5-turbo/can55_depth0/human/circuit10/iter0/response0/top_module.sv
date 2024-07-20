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
    if (state_reg)
        q_reg <= 1'b1;
    else
        q_reg <= 1'b0;
end

assign q = q_reg;
assign state = state_reg;

endmodule
