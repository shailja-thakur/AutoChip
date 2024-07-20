module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter [2:0] IDLE = 3'd0, ONE = 3'd1, TWO = 3'd2, THREE = 3'd3, FOUR = 3'd4, FIVE = 3'd5, ERROR = 3'd6;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in == 1'b0)
                next_state = ONE;
            else
                next_state = IDLE;
        end
        ONE: begin
            if (in == 1'b1)
                next_state = TWO;
            else
                next_state = IDLE;
        end
        TWO: begin
            if (in == 1'b1)
                next_state = THREE;
            else
                next_state = IDLE;
        end
        THREE: begin
            if (in == 1'b1)
                next_state = FOUR;
            else
                next_state = IDLE;
        end
        FOUR: begin
            if (in == 1'b1)
                next_state = FIVE;
            else
                next_state = IDLE;
        end
        FIVE: begin
            if (in == 1'b1) begin
                next_state = ERROR;
                err = 1'b1;
            end
            else begin
                next_state = IDLE;
                disc = 1'b1;
            end
        end
        ERROR: begin
            if (in == 1'b1)
                next_state = ERROR;
            else
                next_state = IDLE;
            err = 1'b1;
        end
    endcase

    if (state == FOUR && in == 1'b0)
        next_state = IDLE;
    if (state == FIVE && in == 1'b0)
        next_state = IDLE;
    if (state == FOUR && in == 1'b1)
        flag = 1'b1;
end

endmodule
