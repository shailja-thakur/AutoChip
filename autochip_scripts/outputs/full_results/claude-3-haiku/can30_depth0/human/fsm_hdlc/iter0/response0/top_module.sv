module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    parameter [2:0] 
        STATE_INIT = 3'd0,
        STATE_ONE  = 3'd1,
        STATE_TWO  = 3'd2,
        STATE_THR  = 3'd3,
        STATE_FOU  = 3'd4,
        STATE_FIV  = 3'd5,
        STATE_SIX  = 3'd6,
        STATE_ERR  = 3'd7;

    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (reset)
            state <= STATE_INIT;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (state)
            STATE_INIT: begin
                if (in == 1'b1)
                    next_state = STATE_ONE;
            end
            STATE_ONE: begin
                if (in == 1'b1)
                    next_state = STATE_TWO;
                else
                    next_state = STATE_INIT;
            end
            STATE_TWO: begin
                if (in == 1'b1)
                    next_state = STATE_THR;
                else
                    next_state = STATE_INIT;
            end
            STATE_THR: begin
                if (in == 1'b1)
                    next_state = STATE_FOU;
                else
                    next_state = STATE_INIT;
            end
            STATE_FOU: begin
                if (in == 1'b1)
                    next_state = STATE_FIV;
                else
                    next_state = STATE_INIT;
            end
            STATE_FIV: begin
                if (in == 1'b1)
                    next_state = STATE_SIX;
                else
                    next_state = STATE_INIT;
            end
            STATE_SIX: begin
                if (in == 1'b0) begin
                    next_state = STATE_INIT;
                    disc = 1'b1;
                end
                else begin
                    next_state = STATE_FLAG;
                    flag = 1'b1;
                end
            end
            STATE_FLAG: begin
                if (in == 1'b1)
                    next_state = STATE_ERR;
                else
                    next_state = STATE_INIT;
            end
            STATE_ERR: begin
                err = 1'b1;
                next_state = STATE_INIT;
            end
        endcase
    end

endmodule
