module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [7:0] x_reg;
reg [7:0] z_reg;

parameter S0 = 0;
parameter S1 = 1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= S0;
    else if (state == S0)
        state <= S1;
    else if (state == S1)
        state <= S0;
end

always @(posedge clk) begin
    if (areset)
        x_reg <= 0;
    else
        x_reg <= {x_reg[6:0], x};
end

always @(state, x_reg) begin
    case (state)
        S0: z_reg <= x_reg;
        S1: z_reg <= ~x_reg + 1;
    endcase
end

assign z = z_reg;

endmodule
