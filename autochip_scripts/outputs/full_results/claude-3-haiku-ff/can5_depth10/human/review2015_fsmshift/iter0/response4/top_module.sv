module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam STATE_IDLE = 2'd0;
localparam STATE_SHIFT_ENABLE = 2'd1;
localparam STATE_SHIFT_DISABLE = 2'd2;

reg [1:0] state;
reg [1:0] next_state;
reg [1:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        counter <= 2'd0;
    end
    else begin
        state <= next_state;
        counter <= counter + 2'd1;
    end
end

always @(*) begin
    case (state)
        STATE_IDLE: begin
            shift_ena = 1'b0;
            if (reset) begin
                next_state = STATE_SHIFT_ENABLE;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_SHIFT_ENABLE: begin
            shift_ena = 1'b1;
            if (counter == 2'd3) begin
                next_state = STATE_SHIFT_DISABLE;
            end
            else begin
                next_state = STATE_SHIFT_ENABLE;
            end
        end
        STATE_SHIFT_DISABLE: begin
            shift_ena = 1'b0;
            next_state = STATE_IDLE;
        end
        default: begin
            shift_ena = 1'b0;
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
