module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [31:0] x_reg = 0;
reg [31:0] z_reg = 0;
reg areset_sync = 0;

always @(posedge clk) begin
    if (areset) begin
        areset_sync <= 1;
        x_reg <= 0;
        z_reg <= 0;
    end else if (areset_sync) begin
        areset_sync <= 0;
    end else begin
        x_reg <= {x_reg[30:0], x};
        z_reg <= (~x_reg + 1);
    end
end

assign z = z_reg[31];

endmodule
