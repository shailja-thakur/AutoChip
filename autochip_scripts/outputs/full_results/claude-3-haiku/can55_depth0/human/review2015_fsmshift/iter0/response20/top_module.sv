module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] state;
parameter IDLE = 2'b00, SHIFT_ENABLE = 2'b01, SHIFT_DONE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= SHIFT_ENABLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            SHIFT_ENABLE: begin
                shift_ena <= 1'b1;
                if (state == SHIFT_ENABLE && &state) begin
                    state <= SHIFT_DONE;
                end
            end
            SHIFT_DONE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= IDLE;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
