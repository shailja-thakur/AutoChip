module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam STATE_INIT = 3'b000;
localparam STATE_ONE = 3'b001;
localparam STATE_TWO = 3'b010;
localparam STATE_THREE = 3'b011;
localparam STATE_FOUR = 3'b100;
localparam STATE_FIVE = 3'b101;
localparam STATE_SIX = 3'b110;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_INIT;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    next_state = state;

    case (state)
        STATE_INIT: begin
            if (in == 1'b0) begin
                next_state = STATE_INIT;
            end
            else begin
                next_state = STATE_ONE;
            end
        end
        STATE_ONE: begin
            if (in == 1'b0) begin
                next_state = STATE_INIT;
            end
            else begin
                next_state = STATE_TWO;
            end
        end
        STATE_TWO: begin
            if (in == 1'b0) begin
                next_state = STATE_INIT;
            end
            else begin
                next_state = STATE_THREE;
            end
        end
        STATE_THREE: begin
            if (in == 1'b0) begin
                next_state = STATE_INIT;
            end
            else begin
                next_state = STATE_FOUR;
            end
        end
        STATE_FOUR: begin
            if (in == 1'b0) begin
                next_state = STATE_INIT;
                disc = 1'b1;
            end
            else begin
                next_state = STATE_FIVE;
            end
        end
        STATE_FIVE: begin
            if (in == 1'b0) begin
                next_state = STATE_INIT;
                flag = 1'b1;
            end
            else begin
                next_state = STATE_SIX;
            end
        end
        STATE_SIX: begin
            if (in == 1'b0) begin
                next_state = STATE_INIT;
                err = 1'b1;
            end
            else begin
                next_state = STATE_SIX;
            end
        end
        default: begin
            next_state = STATE_INIT;
        end
    endcase
end

endmodule
