module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] state;
parameter RESET = 2'd0, SHIFT = 2'd1, IDLE = 2'd2;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            RESET: begin
                shift_ena <= 1'b1;
                if (shift_ena) begin
                    state <= SHIFT;
                end
            end
            SHIFT: begin
                shift_ena <= 1'b1;
                if (shift_ena == 1'b1 && state == SHIFT) begin
                    state <= IDLE;
                end
            end
            IDLE: begin
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
