module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [31:0] x_reg = 0;
reg [31:0] z_reg = 0;

always @(posedge clk or negedge areset) begin
    if (~areset) begin
        x_reg <= 0;
        z_reg <= 0;
        z <= 0;
    end else if (~areset) begin
        x_reg <= {x_reg[30:0], x};
        z_reg <= (~x_reg + 1);
        z <= z_reg[31];
    end
end

endmodule
