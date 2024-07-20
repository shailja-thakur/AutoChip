module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [3:0] STATE_WAIT = 4'd0,
                STATE_1 = 4'd1,
                STATE_10 = 4'd2,
                STATE_101 = 4'd3,
                STATE_1101 = 4'd4;

reg [3:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_WAIT;
        start_shifting <= 1'b0;
    end
    else begin
        current_state <= next_state;
        if (current_state == STATE_1101)
            start_shifting <= 1'b1;
    end
end

always @(*) begin
    case (current_state)
        STATE_WAIT: begin
            if (data == 1'b1)
                next_state = STATE_1;
            else
                next_state = STATE_WAIT;
        end
        STATE_1: begin
            if (data == 1'b0)
                next_state = STATE_10;
            else
                next_state = STATE_1;
        end
        STATE_10: begin
            if (data == 1'b1)
                next_state = STATE_101;
            else
                next_state = STATE_WAIT;
        end
        STATE_101: begin
            if (data == 1'b1)
                next_state = STATE_1101;
            else
                next_state = STATE_WAIT;
        end
        STATE_1101: begin
            next_state = STATE_1101;
        end
        default: begin
            next_state = STATE_WAIT;
        end
    endcase
end

endmodule
