module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    typedef enum reg [2:0] {
        S_IDLE = 3'd0,
        S1     = 3'd1,
        S11    = 3'd2,
        S110   = 3'd3,
        S1101  = 3'd4
    } state_t;

    state_t state, next_state;

    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        start_shifting = 0;
        case (state)
            S_IDLE: if (data) next_state = S1; else next_state = S_IDLE;
            S1:     if (data) next_state = S11; else next_state = S_IDLE;
            S11:    if (data) next_state = S11; else next_state = S110;
            S110:   if (data) next_state = S1101; else next_state = S_IDLE;
            S1101:  begin
                       start_shifting = 1;
                       next_state = S1101;
                    end
            default: next_state = S_IDLE;
        endcase
    end

endmodule
