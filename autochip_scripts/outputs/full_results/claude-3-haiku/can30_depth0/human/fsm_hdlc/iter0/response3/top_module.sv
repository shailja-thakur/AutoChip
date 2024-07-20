module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter STATE_ZERO = 2'b00; // 0 in the stream
parameter STATE_ONE = 2'b01; // 1 in the stream
parameter STATE_ERROR = 2'b11; // Error state (7 or more 1s)

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_ZERO;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        STATE_ZERO: begin
            if (in == 1'b1) begin
                next_state = STATE_ONE;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        STATE_ONE: begin
            if (in == 1'b1) begin
                next_state = STATE_ERROR;
                err = 1'b1;
            end else begin
                next_state = STATE_ZERO;
                disc = 1'b1;
            end
        end
        STATE_ERROR: begin
            if (in == 1'b1) begin
                next_state = STATE_ERROR;
                err = 1'b1;
            end else begin
                next_state = STATE_ZERO;
            end
        end
        default: begin
            next_state = STATE_ZERO;
        end
    endcase
    if (state == STATE_ONE && in == 1'b0) begin
        flag = 1'b1;
    end
end

endmodule
