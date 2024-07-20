module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam SHIFT_CYCLES = 4;

reg [1:0] state;
localparam STATE_IDLE = 2'b00;
localparam STATE_SHIFT = 2'b01;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_SHIFT;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            STATE_SHIFT: begin
                if (shift_ena == 1'b1 && SHIFT_CYCLES == 4'd4) begin
                    shift_ena <= 1'b0;
                    state <= STATE_IDLE;
                end
                else begin
                    shift_ena <= 1'b1;
                end
            end
            STATE_IDLE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= STATE_IDLE;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
