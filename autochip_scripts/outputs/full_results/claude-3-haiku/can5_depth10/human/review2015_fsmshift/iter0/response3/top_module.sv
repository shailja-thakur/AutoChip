module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] state;
parameter IDLE = 2'b00, SHIFT_ENABLE = 2'b01, SHIFT_HOLD = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= SHIFT_ENABLE;
        shift_ena <= 1'b1;
    end else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
            end
            SHIFT_ENABLE: begin
                shift_ena <= 1'b1;
                state <= SHIFT_HOLD;
            end
            SHIFT_HOLD: begin
                shift_ena <= 1'b0;
                if (shift_ena == 1'b1) begin
                    state <= SHIFT_HOLD;
                end else begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
