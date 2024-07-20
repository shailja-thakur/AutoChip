module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLES_TO_ENABLE = 4;

reg [1:0] state;
parameter IDLE = 2'b00, ENABLE = 2'b01, DISABLED = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                state <= ENABLE;
            end
            ENABLE: begin
                if (CYCLES_TO_ENABLE == 0) begin
                    shift_ena <= 1'b0;
                    state <= DISABLED;
                end
                else begin
                    shift_ena <= 1'b1;
                    CYCLES_TO_ENABLE <= CYCLES_TO_ENABLE - 1;
                end
            end
            DISABLED: begin
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
