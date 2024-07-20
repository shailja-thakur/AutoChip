module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLE_COUNT = 4;

reg [1:0] state;
localparam IDLE = 2'b00, SHIFT_EN = 2'b01, SHIFT_DISABLE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                if (reset) begin
                    state <= IDLE;
                end
                else begin
                    state <= SHIFT_EN;
                end
            end
            SHIFT_EN: begin
                shift_ena <= 1'b1;
                if (reset) begin
                    state <= IDLE;
                end
                else if (CYCLE_COUNT == 4) begin
                    state <= SHIFT_DISABLE;
                end
            end
            SHIFT_DISABLE: begin
                shift_ena <= 1'b0;
                if (reset) begin
                    state <= IDLE;
                end
                else begin
                    state <= SHIFT_DISABLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
