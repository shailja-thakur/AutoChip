module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [31:0] x_reg;
reg [31:0] z_reg;
reg reset_state;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        x_reg <= 0;
        z_reg <= 0;
        reset_state <= 1;
    end else if (areset == 1) begin
        if (reset_state) begin
            x_reg <= 0;
            z_reg <= 0;
        end else begin
            x_reg <= {x_reg[30:0], x};
            z_reg <= ~x_reg + 1;
        end
        reset_state <= 0;
    end
end

assign z = z_reg[31];

endmodule
