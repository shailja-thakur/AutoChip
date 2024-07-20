module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] state;
parameter IDLE = 2'b00, SHIFT_ENABLE = 2'b01, FINISH = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                state <= SHIFT_ENABLE;
            end
            SHIFT_ENABLE: begin
                shift_ena <= 1'b1;
                if (shift_ena == 1'b1) begin
                    state <= FINISH;
                end
            end
            FINISH: begin
                shift_ena <= 1'b0;
                if (reset) begin
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
