module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam RESET_CYCLES = 4;

reg [1:0] state;
parameter IDLE = 2'b00, ENABLE = 2'b01, HOLD = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= ENABLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
            end
            ENABLE: begin
                shift_ena <= 1'b1;
                if (state == ENABLE && &state) begin
                    state <= HOLD;
                end
            end
            HOLD: begin
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
