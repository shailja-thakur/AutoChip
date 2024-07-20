module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [31:0] x_reg = 0;
reg [31:0] z_reg = 0;
reg [4:0] counter = 0;

always @(posedge clk or negedge areset) begin
    if (~areset) begin
        x_reg <= 0;
        z_reg <= 0;
        z <= 0;
        counter <= 0;
    end else begin
        x_reg <= {x_reg[30:0], x};
        z_reg <= (~x_reg + 1);
        
        if (counter == 4) begin
            z <= z_reg[31];
            counter <= 0;
        end else begin
            z <= 0;
            counter <= counter + 1;
        end
    end
end

endmodule
