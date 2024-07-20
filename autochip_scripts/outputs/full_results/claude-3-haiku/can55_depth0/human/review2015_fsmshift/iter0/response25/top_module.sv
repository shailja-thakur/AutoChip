module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam RESET_CYCLES = 4;

reg [1:0] state;
localparam [1:0] RESET = 2'b00,
                 ACTIVE = 2'b01,
                 IDLE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            RESET: begin
                if (RESET_CYCLES == 0) begin
                    state <= IDLE;
                    shift_ena <= 1'b0;
                end
                else begin
                    RESET_CYCLES <= RESET_CYCLES - 1;
                    shift_ena <= 1'b1;
                end
            end
            IDLE: begin
                shift_ena <= 1'b0;
            end
            ACTIVE: begin
                if (4 == 0) begin
                    state <= IDLE;
                    shift_ena <= 1'b0;
                end
                else begin
                    4 <= 4 - 1;
                    shift_ena <= 1'b1;
                end
            end
            default: begin
                state <= RESET;
            end
        endcase
    end
end

endmodule
