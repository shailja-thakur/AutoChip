module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] STATE_IDLE = 2'b00,
                 STATE_WAIT_1 = 2'b01,
                 STATE_WAIT_10 = 2'b10,
                 STATE_WAIT_101 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_WAIT_101 && data == 1'b1) begin
            start_shifting <= 1;
        end
    end
end

always @(*) begin
    case (state)
        STATE_IDLE: begin
            if (data == 1'b1) begin
                next_state = STATE_WAIT_1;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_WAIT_1: begin
            if (data == 1'b0) begin
                next_state = STATE_WAIT_10;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_WAIT_10: begin
            if (data == 1'b1) begin
                next_state = STATE_WAIT_101;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_WAIT_101: begin
            if (data == 1'b1) begin
                next_state = STATE_WAIT_101;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
