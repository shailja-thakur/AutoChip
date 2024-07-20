module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam STATE_IDLE = 2'd0;
localparam STATE_SHIFT = 2'd1;
localparam STATE_HOLD  = 2'd2;

reg [1:0] state, next_state;
reg [1:0] cycle_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        cycle_count <= 2'd0;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_IDLE: begin
                shift_ena <= 1'b0;
                cycle_count <= 2'd0;
            end
            STATE_SHIFT: begin
                shift_ena <= 1'b1;
                cycle_count <= cycle_count + 2'd1;
                if (cycle_count == 2'd3)
                    next_state <= STATE_HOLD;
            end
            STATE_HOLD: begin
                shift_ena <= 1'b0;
            end
            default: begin
                next_state <= STATE_IDLE;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_IDLE: next_state = (reset) ? STATE_SHIFT : STATE_IDLE;
        STATE_SHIFT: next_state = STATE_SHIFT;
        STATE_HOLD: next_state = STATE_IDLE;
        default: next_state = STATE_IDLE;
    endcase
end

endmodule
