module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

parameter STATE_RESET = 2'b00;
parameter STATE_SHIFT = 2'b01;
parameter STATE_IDLE = 2'b10;

reg [1:0] current_state, next_state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_RESET;
        count <= 2'd0;
    end
    else begin
        current_state <= next_state;
        count <= count + 2'd1;
    end
end

always @(*) begin
    case (current_state)
        STATE_RESET: begin
            shift_ena = 1'b1;
            if (count == 2'd3) begin
                next_state = STATE_IDLE;
            end
            else begin
                next_state = STATE_RESET;
            end
        end
        STATE_IDLE: begin
            shift_ena = 1'b0;
            next_state = STATE_IDLE;
        end
        default: begin
            shift_ena = 1'b1;
            if (count == 2'd3) begin
                next_state = STATE_IDLE;
            end
            else begin
                next_state = STATE_SHIFT;
            end
        end
    endcase
end

endmodule
