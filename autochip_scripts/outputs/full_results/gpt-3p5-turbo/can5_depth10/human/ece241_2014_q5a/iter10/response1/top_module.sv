module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [31:0] x_reg = 0;
reg [31:0] z_reg = 0;
reg areset_reg;

always @(posedge clk) begin
    if (areset) begin
        x_reg <= 0;
        z_reg <= 0;
        areset_reg <= 1;
    end else if (areset_reg) begin
        x_reg <= x;
        z_reg <= ~x_reg + 1;
        areset_reg <= 0;
    end else begin
        x_reg <= {x_reg[30:0], x};
        z_reg <= ~x_reg + 1;
    end
end

assign z = z_reg[31];

endmodule
