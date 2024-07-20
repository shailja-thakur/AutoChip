module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [2:0] state;
parameter IDLE = 3'b000, SHIFT = 3'b001, COMPLEMENT = 3'b010;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) state <= SHIFT;
                z <= 0;
            end
            SHIFT: begin
                if (state == SHIFT && !areset) begin
                    state <= SHIFT;
                    z <= x;
                end
                else begin
                    state <= COMPLEMENT;
                    z <= 0;
                end
            end
            COMPLEMENT: begin
                if (state == COMPLEMENT && !areset) begin
                    state <= COMPLEMENT;
                    z <= ~x;
                end
                else begin
                    state <= IDLE;
                    z <= 0;
                end
            end
            default: begin
                state <= IDLE;
                z <= 0;
            end
        endcase
    end
end

endmodule
