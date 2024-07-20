module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg q_reg;
reg state_reg;

always @ (posedge clk) begin
    q_reg <= q;
    state_reg <= state;
    if (state_reg) begin
        q <= a & b;
    end else begin
        q <= 1'b0;
    end
    case ({a, b})
        2'd1: state <= 1'b1;
        default: state <= 1'b0;
    endcase
end

always @* begin
    q = q_reg;
    state = state_reg;
end

endmodule
