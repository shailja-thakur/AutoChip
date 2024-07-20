module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] 
    STATE_0 = 2'b00,
    STATE_1 = 2'b01,
    STATE_10 = 2'b10,
    STATE_101 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_0;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == STATE_101)
            start_shifting <= 1'b1;
    end
end

always @(*) begin
    case (state)
        STATE_0: begin
            if (data == 1'b1)
                next_state = STATE_1;
            else
                next_state = STATE_0;
        end
        STATE_1: begin
            if (data == 1'b1)
                next_state = STATE_10;
            else
                next_state = STATE_0;
        end
        STATE_10: begin
            if (data == 1'b0)
                next_state = STATE_101;
            else
                next_state = STATE_1;
        end
        STATE_101: begin
            next_state = STATE_101;
        end
        default: begin
            next_state = STATE_0;
        end
    endcase
end

endmodule
