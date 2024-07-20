module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam STATE_ZERO = 0, 
           STATE_ONE = 1,
           STATE_ONE_ONE = 2, 
           STATE_ONE_ONE_ZERO = 3;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= STATE_ZERO;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        STATE_ZERO: begin
            if (data == 1'b0)
                next_state = STATE_ONE;
            else
                next_state = STATE_ZERO;
            start_shifting = 1'b0;
        end
        STATE_ONE: begin
            if (data == 1'b1)
                next_state = STATE_ONE_ONE;
            else
                next_state = STATE_ZERO;
            start_shifting = 1'b0;
        end
        STATE_ONE_ONE: begin
            if (data == 1'b0)
                next_state = STATE_ONE_ONE_ZERO;
            else
                next_state = STATE_ONE_ONE;
            start_shifting = 1'b0;
        end
        STATE_ONE_ONE_ZERO: begin
            if (data == 1'b1)
                next_state = STATE_ONE;
            else
                next_state = STATE_ZERO;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = STATE_ZERO;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
