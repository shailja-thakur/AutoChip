module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg q_reg, p_reg;

always @(posedge clock) begin
    q_reg <= a;
    p_reg <= q_reg;
end

assign q = q_reg;
assign p = p_reg;

endmodule
