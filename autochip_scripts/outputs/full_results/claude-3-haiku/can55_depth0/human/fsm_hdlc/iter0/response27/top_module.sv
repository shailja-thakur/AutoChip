module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam STATE_ZERO = 0;
localparam STATE_ONE = 1;
localparam STATE_TWO = 2;
localparam STATE_THREE = 3;
localparam STATE_FOUR = 4;
localparam STATE_FIVE = 5;
localparam STATE_SIX = 6;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_ZERO;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    next_state = state;
    case (state)
        STATE_ZERO: begin
            if (in == 1'b0) begin
                next_state = STATE_ONE;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_ONE: begin
            if (in == 1'b1) begin
                next_state = STATE_TWO;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_TWO: begin
            if (in == 1'b1) begin
                next_state = STATE_THREE;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_THREE: begin
            if (in == 1'b1) begin
                next_state = STATE_FOUR;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_FOUR: begin
            if (in == 1'b1) begin
                next_state = STATE_FIVE;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_FIVE: begin
            if (in == 1'b0) begin
                disc = 1'b1;
                next_state = STATE_ZERO;
            end else begin
                next_state = STATE_SIX;
            end
        end
        STATE_SIX: begin
            if (in == 1'b1) begin
                flag = 1'b1;
                next_state = STATE_ZERO;
            end else begin
                err = 1'b1;
                next_state = STATE_ZERO;
            end
        end
    endcase
end

endmodule
