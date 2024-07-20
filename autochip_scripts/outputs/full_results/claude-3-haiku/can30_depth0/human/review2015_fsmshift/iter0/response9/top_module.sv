module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam SHIFT_CYCLES = 4;

reg [1:0] state;
parameter IDLE = 2'b00, SHIFT = 2'b01, DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                if (SHIFT_CYCLES == 4) begin
                    state <= SHIFT;
                end
            end
            SHIFT: begin
                shift_ena <= 1'b1;
                if (SHIFT_CYCLES == 0) begin
                    state <= DONE;
                end
                else begin
                    SHIFT_CYCLES <= SHIFT_CYCLES - 1;
                end
            end
            DONE: begin
                shift_ena <= 1'b0;
                if (reset) begin
                    state <= IDLE;
                    SHIFT_CYCLES <= 4;
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
