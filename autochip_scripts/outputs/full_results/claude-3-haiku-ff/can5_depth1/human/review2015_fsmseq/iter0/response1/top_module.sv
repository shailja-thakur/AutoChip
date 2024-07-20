module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam STATE_IDLE = 2'b00;
localparam STATE_FOUND_1 = 2'b01;
localparam STATE_FOUND_11 = 2'b10;
localparam STATE_FOUND_1101 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_FOUND_1101)
            start_shifting <= 1;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_IDLE: begin
            if (data == 1'b1)
                next_state = STATE_FOUND_1;
            else
                next_state = STATE_IDLE;
        end
        STATE_FOUND_1: begin
            if (data == 1'b1)
                next_state = STATE_FOUND_11;
            else
                next_state = STATE_IDLE;
        end
        STATE_FOUND_11: begin
            if (data == 1'b0)
                next_state = STATE_FOUND_1101;
            else
                next_state = STATE_IDLE;
        end
        STATE_FOUND_1101: begin
            next_state = STATE_FOUND_1101;
        end
    endcase
end

endmodule
