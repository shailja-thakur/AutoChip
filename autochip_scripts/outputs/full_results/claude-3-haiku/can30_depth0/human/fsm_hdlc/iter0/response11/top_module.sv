module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam STATE_ZERO = 0,
           STATE_ONE = 1,
           STATE_TWO = 2,
           STATE_THREE = 3,
           STATE_FOUR = 4,
           STATE_FIVE = 5,
           STATE_SIX = 6;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_ZERO;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    disc = 0;
    flag = 0;
    err = 0;

    case (state)
        STATE_ZERO: begin
            if (in == 0) begin
                next_state = STATE_ONE;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_ONE: begin
            if (in == 1) begin
                next_state = STATE_TWO;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_TWO: begin
            if (in == 1) begin
                next_state = STATE_THREE;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_THREE: begin
            if (in == 1) begin
                next_state = STATE_FOUR;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_FOUR: begin
            if (in == 1) begin
                next_state = STATE_FIVE;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_FIVE: begin
            if (in == 1) begin
                next_state = STATE_SIX;
                disc = 1;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_SIX: begin
            if (in == 0) begin
                next_state = STATE_ZERO;
                flag = 1;
            end
            else if (in == 1) begin
                next_state = STATE_SIX;
                err = 1;
            end
            else begin
                next_state = STATE_ZERO;
            end
        end
    endcase
end

endmodule
