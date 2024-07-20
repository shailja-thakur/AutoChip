module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam IDLE = 1'b0, CONVERT = 1'b1;
reg state;
reg [7:0] x_reg;
reg [7:0] complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        x_reg <= 8'b0;
        complement <= 8'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (~areset) begin
                    state <= CONVERT;
                    x_reg <= 8'b0;
                    complement <= 8'b0;
                end
            end
            CONVERT: begin
                x_reg <= {x_reg[6:0], x};
                complement <= {complement[6:0], ~x};
                if (areset) begin
                    state <= IDLE;
                    z <= 1'b0;
                end
                else begin
                    z <= complement[7];
                end
            end
        endcase
    end
end

endmodule
