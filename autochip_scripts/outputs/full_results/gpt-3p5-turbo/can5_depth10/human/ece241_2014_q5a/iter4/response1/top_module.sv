module top_module (
    input clk,
    input areset,
    input x,
    output reg z 
);

reg [31:0] x_reg;
reg [31:0] z_reg;
reg start_conversion;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        x_reg <= 0;
        z_reg <= 0;
    end else if (areset == 1) begin
        if (start_conversion) begin
            x_reg <= {x_reg[30:0], x};
            z_reg <= ~x_reg + 1;
        end else begin
            x_reg <= x_reg;
            z_reg <= z_reg;
        end
    end
end

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        start_conversion <= 0;
    end else if (areset == 1) begin
        if (start_conversion) begin
            start_conversion <= 0;
        end else begin
            if (~x_reg[31] & x) begin
                start_conversion <= 1;
            end else begin
                start_conversion <= 0;
            end
        end
    end
end

assign z = z_reg[0];

endmodule
