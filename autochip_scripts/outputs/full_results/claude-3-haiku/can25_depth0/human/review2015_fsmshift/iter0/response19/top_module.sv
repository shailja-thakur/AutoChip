module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] state;
parameter IDLE = 2'b00, SHIFT = 2'b01, HOLD = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                state <= SHIFT;
            end
            SHIFT: begin
                shift_ena <= 1'b1;
                state <= HOLD;
            end
            HOLD: begin
                shift_ena <= 1'b0;
                if (state == HOLD) begin
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
