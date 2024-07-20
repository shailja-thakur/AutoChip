module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

parameter ENABLE_CYCLES = 4;

reg [1:0] state;
localparam RESET = 2'b00,
          ENABLE = 2'b01,
          HOLD = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            RESET: begin
                shift_ena <= 1'b1;
                if (ENABLE_CYCLES == 4'b0100) begin
                    state <= HOLD;
                end
                else begin
                    state <= ENABLE;
                end
            end
            ENABLE: begin
                shift_ena <= 1'b1;
                if (ENABLE_CYCLES == 4'b0100) begin
                    state <= HOLD;
                end
                else begin
                    ENABLE_CYCLES <= ENABLE_CYCLES - 1;
                end
            end
            HOLD: begin
                shift_ena <= 1'b0;
                state <= HOLD;
            end
            default: begin
                state <= RESET;
                shift_ena <= 1'b1;
            end
        endcase
    end
end

endmodule
