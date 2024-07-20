module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam SHIFT_ENA_CYCLES = 4;

reg [1:0] state;
parameter [1:0] IDLE = 2'b00, SHIFT_ENA_ACTIVE = 2'b01;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
            end
            SHIFT_ENA_ACTIVE: begin
                shift_ena <= 1'b1;
                if (shift_ena == 1'b1 && state != IDLE) begin
                    if (state == SHIFT_ENA_ACTIVE && SHIFT_ENA_CYCLES == 0) begin
                        state <= IDLE;
                        shift_ena <= 1'b0;
                    end
                    else begin
                        state <= SHIFT_ENA_ACTIVE;
                        SHIFT_ENA_CYCLES <= SHIFT_ENA_CYCLES - 1;
                    end
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
