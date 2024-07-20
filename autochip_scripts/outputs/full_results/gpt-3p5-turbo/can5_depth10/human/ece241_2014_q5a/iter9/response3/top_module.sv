module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [31:0] x_reg = 0;
reg [31:0] z_reg = 0;
reg [4:0] count = 0;
reg start_conversion = 0;

always @(posedge clk or negedge areset) begin
    if (~areset) begin
        x_reg <= 0;
        z_reg <= 0;
        count <= 0;
        start_conversion <= 0;
        z <= 0;
    end else begin
        x_reg <= {x_reg[30:0], x};
        count <= count + 1;
        if (count == 31) begin
            start_conversion <= 1;
            count <= 0;
        end
    end
end

always @(posedge clk or negedge areset) begin
    if (~areset) begin
        z_reg <= 0;
    end else begin
        if (start_conversion) begin
            z_reg <= (~x_reg + 1);
        end
    end
end

always @(posedge clk or negedge areset) begin
    if (~areset) begin
        z <= 0;
    end else begin
        if (start_conversion) begin
            z <= z_reg[31];
        end
    end
end

endmodule
