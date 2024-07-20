module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg z;
reg [7:0] count;
reg [7:0] x_reg;
reg [7:0] z_reg;

always @(posedge clk) begin
    if (areset) begin
        count <= 0;
        x_reg <= 0;
        z_reg <= 0;
    end else begin
        if (count < 8) begin
            x_reg <= {x, x_reg[7:1]};
            count <= count + 1;
        end else begin
            z_reg <= ~x_reg + 1;
            count <= 0;
        end
    end
end

assign z = areset ? 0 : z_reg;

endmodule
