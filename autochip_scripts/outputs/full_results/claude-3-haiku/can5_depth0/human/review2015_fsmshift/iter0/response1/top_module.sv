module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam ENABLE_CYCLES = 4;

reg [1:0] state;
parameter IDLE = 2'b00;
parameter ENABLE = 2'b01;
parameter DISABLE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                state <= ENABLE;
            end
            ENABLE: begin
                shift_ena <= 1'b1;
                if (shift_ena == 1'b1 && ENABLE_CYCLES == 4) begin
                    state <= DISABLE;
                end
            end
            DISABLE: begin
                shift_ena <= 1'b0;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
