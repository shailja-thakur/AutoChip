module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;

localparam S_IDLE = 3'b000,
          S_ONE  = 3'b001,
          S_TWO  = 3'b010,
          S_THREE = 3'b011,
          S_FOUR = 3'b100,
          S_FIVE = 3'b101,
          S_SIX  = 3'b110;

always @(posedge clk) begin
    if (reset)
        state <= S_IDLE;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        S_IDLE: begin
            if (in)
                next_state = S_ONE;
        end
        S_ONE: begin
            if (in)
                next_state = S_TWO;
            else
                next_state = S_IDLE;
        end
        S_TWO: begin
            if (in)
                next_state = S_THREE;
            else
                next_state = S_IDLE;
        end
        S_THREE: begin
            if (in)
                next_state = S_FOUR;
            else
                next_state = S_IDLE;
        end
        S_FOUR: begin
            if (in)
                next_state = S_FIVE;
            else
                next_state = S_IDLE;
        end
        S_FIVE: begin
            if (in)
                next_state = S_SIX;
            else
                next_state = S_IDLE;
        end
        S_SIX: begin
            if (in) begin
                err = 1'b1;
                next_state = S_SIX;
            end
            else begin
                disc = 1'b1;
                next_state = S_IDLE;
            end
        end
    endcase

    if (state == S_FIVE && !in)
        flag = 1'b1;
end

endmodule
