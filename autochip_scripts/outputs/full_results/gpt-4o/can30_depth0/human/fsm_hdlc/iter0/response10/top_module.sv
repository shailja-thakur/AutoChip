module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [3:0] {
        STATE_IDLE = 4'd0,
        STATE_1 = 4'd1,
        STATE_11 = 4'd2,
        STATE_111 = 4'd3,
        STATE_1111 = 4'd4,
        STATE_11111 = 4'd5,
        STATE_111110 = 4'd6,
        STATE_111111 = 4'd7,
        STATE_ERROR = 4'd8
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state;  // Default to no state change
        disc = 0;
        flag = 0;
        err = 0;
        case (state)
            STATE_IDLE: begin
                if (in)
                    next_state = STATE_1;
            end
            STATE_1: begin
                if (in)
                    next_state = STATE_11;
                else
                    next_state = STATE_IDLE;
            end
            STATE_11: begin
                if (in)
                    next_state = STATE_111;
                else
                    next_state = STATE_IDLE;
            end
            STATE_111: begin
                if (in)
                    next_state = STATE_1111;
                else
                    next_state = STATE_IDLE;
            end
            STATE_1111: begin
                if (in)
                    next_state = STATE_11111;
                else
                    next_state = STATE_IDLE;
            end
            STATE_11111: begin
                if (in)
                    next_state = STATE_111110;
                else begin
                    disc = 1;  // Indicate that a bit needs to be discarded
                    next_state = STATE_IDLE;
                end
            end
            STATE_111110: begin
                if (in) begin
                    flag = 1;  // Indicate a flag
                    next_state = STATE_111111;
                end else
                    next_state = STATE_IDLE;
            end
            STATE_111111: begin
                if (in) begin
                    err = 1;  // Indicate an error
                    next_state = STATE_ERROR;
                end else
                    next_state = STATE_IDLE;
            end
            STATE_ERROR: begin
                if (!in)  // Stay in error state until a 0 is received
                    next_state = STATE_IDLE;
            end
        endcase
    end

    // State registers
    always @(posedge clk) begin
        if (reset)
            state <= STATE_IDLE;
        else
            state <= next_state;
    end

endmodule
