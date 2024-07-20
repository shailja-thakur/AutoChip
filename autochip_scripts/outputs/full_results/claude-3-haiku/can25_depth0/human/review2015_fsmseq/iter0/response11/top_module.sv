module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter STATE_IDLE = 4'b0000;
parameter STATE_1 = 4'b0001;
parameter STATE_10 = 4'b0010;
parameter STATE_101 = 4'b0100;
parameter STATE_1101 = 4'b1000;

reg [3:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_IDLE: begin
            if (data == 1'b1)
                next_state = STATE_1;
            else
                next_state = STATE_IDLE;
            start_shifting = 1'b0;
        end
        STATE_1: begin
            if (data == 1'b0)
                next_state = STATE_10;
            else
                next_state = STATE_1;
            start_shifting = 1'b0;
        end
        STATE_10: begin
            if (data == 1'b1)
                next_state = STATE_101;
            else
                next_state = STATE_IDLE;
            start_shifting = 1'b0;
        end
        STATE_101: begin
            if (data == 1'b1)
                next_state = STATE_1101;
            else
                next_state = STATE_IDLE;
            start_shifting = 1'b0;
        end
        STATE_1101: begin
            next_state = STATE_1101;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = STATE_IDLE;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
