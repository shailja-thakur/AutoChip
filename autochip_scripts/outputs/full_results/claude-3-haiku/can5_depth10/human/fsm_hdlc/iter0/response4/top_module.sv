module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] WAIT_ZERO = 3'd0,
                 WAIT_1    = 3'd1,
                 WAIT_2    = 3'd2,
                 WAIT_3    = 3'd3,
                 WAIT_4    = 3'd4,
                 WAIT_5    = 3'd5,
                 WAIT_6    = 3'd6,
                 ERROR     = 3'd7;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= WAIT_ZERO;
    else
        state <= next_state;
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    next_state = state;

    case (state)
        WAIT_ZERO: begin
            if (in == 1'b0)
                next_state = WAIT_1;
        end
        WAIT_1: begin
            if (in == 1'b1)
                next_state = WAIT_2;
            else
                next_state = WAIT_ZERO;
        end
        WAIT_2: begin
            if (in == 1'b1)
                next_state = WAIT_3;
            else
                next_state = WAIT_ZERO;
        end
        WAIT_3: begin
            if (in == 1'b1)
                next_state = WAIT_4;
            else
                next_state = WAIT_ZERO;
        end
        WAIT_4: begin
            if (in == 1'b1)
                next_state = WAIT_5;
            else
                next_state = WAIT_ZERO;
        end
        WAIT_5: begin
            if (in == 1'b1)
                next_state = WAIT_6;
            else
                next_state = WAIT_ZERO;
        end
        WAIT_6: begin
            if (in == 1'b1) begin
                next_state = ERROR;
                err = 1'b1;
            end
            else begin
                next_state = WAIT_ZERO;
                disc = 1'b1;
            end
        end
        ERROR: begin
            if (in == 1'b0)
                next_state = WAIT_ZERO;
            else
                next_state = ERROR;
            err = 1'b1;
        end
    endcase

    if (state == WAIT_6 && in == 1'b0)
        next_state = WAIT_ZERO;
        flag = 1'b1;
end

endmodule
