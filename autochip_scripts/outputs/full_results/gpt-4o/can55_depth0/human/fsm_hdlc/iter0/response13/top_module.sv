module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    typedef enum logic [2:0] {
        S_IDLE   = 3'd0,
        S_1      = 3'd1,
        S_11     = 3'd2,
        S_111    = 3'd3,
        S_1111   = 3'd4,
        S_11111  = 3'd5,
        S_011111 = 3'd6,
        S_0111111= 3'd7,
        S_ERROR  = 3'd8
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        case (state)
            S_IDLE:    next_state = (in) ? S_IDLE   : S_1;
            S_1:       next_state = (in) ? S_11     : S_1;
            S_11:      next_state = (in) ? S_111    : S_1;
            S_111:     next_state = (in) ? S_1111   : S_1;
            S_1111:    next_state = (in) ? S_11111  : S_1;
            S_11111:   next_state = (in) ? S_011111 : S_1;
            S_011111:  next_state = (in) ? S_0111111: S_1;
            S_0111111: next_state = (in) ? S_ERROR  : S_1;
            S_ERROR:   next_state = S_IDLE;
        endcase
    end

    assign disc = (state == S_011111);
    assign flag = (state == S_0111111);
    assign err = (state == S_ERROR);
endmodule
