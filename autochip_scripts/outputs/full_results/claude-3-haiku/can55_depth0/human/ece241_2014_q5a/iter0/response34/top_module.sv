module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_IDLE = 0, STATE_CONVERT = 1;
reg state;
reg [7:0] input_reg;
reg [7:0] complement_reg;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_IDLE;
        input_reg <= 0;
        complement_reg <= 0;
        z <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (!areset) begin
                    state <= STATE_CONVERT;
                    input_reg <= 0;
                    complement_reg <= 0;
                end
            end
            STATE_CONVERT: begin
                input_reg <= {input_reg[6:0], x};
                complement_reg <= ~input_reg + 1;
                z <= complement_reg[0];
            end
        endcase
    end
end

endmodule
