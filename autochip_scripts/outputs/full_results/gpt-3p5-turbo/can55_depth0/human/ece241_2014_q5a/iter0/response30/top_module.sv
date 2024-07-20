module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg z_reg;
reg [15:0] x_reg;

parameter IDLE = 2'b00;
parameter NEGATE = 2'b01;
parameter OUTPUT = 2'b10;

reg [1:0] state = IDLE;

always@(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        z_reg <= 1'b0;
        x_reg <= 16'b0;
    end else begin
        case (state)
            IDLE: begin
                if (x) begin
                    state <= NEGATE;
                    x_reg <= 16'b1;
                    z_reg <= ~x;
                end
            end
            NEGATE: begin
                if (x) begin
                    state <= NEGATE;
                    x_reg <= x_reg << 1;
                    z_reg <= ~(x_reg + 1);
                end else begin
                    state <= OUTPUT;
                end
            end
            OUTPUT: begin
                state <= IDLE;
                z_reg <= z_reg;
            end
        endcase
    end
end

assign z = z_reg;

endmodule
