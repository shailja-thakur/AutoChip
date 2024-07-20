module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam ENABLE_CYCLES = 4;

reg [1:0] state;
localparam [1:0] RESET = 2'b00,
                 ENABLE = 2'b01,
                 IDLE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            RESET: begin
                shift_ena <= 1'b1;
                if (ENABLE_CYCLES == 4'd4) begin
                    state <= IDLE;
                    shift_ena <= 1'b0;
                end
                else begin
                    state <= ENABLE;
                end
            end
            ENABLE: begin
                shift_ena <= 1'b1;
                if (ENABLE_CYCLES == 4'd4) begin
                    state <= IDLE;
                    shift_ena <= 1'b0;
                end
                else begin
                    ENABLE_CYCLES <= ENABLE_CYCLES + 1;
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
