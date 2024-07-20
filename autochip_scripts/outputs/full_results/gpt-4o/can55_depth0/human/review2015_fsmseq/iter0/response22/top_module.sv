module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {
        IDLE = 3'd0,
        S1   = 3'd1,
        S11  = 3'd2,
        S110 = 3'd3,
        S1101= 3'd4
    } state_t;

    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            if (state == S1101) begin
                start_shifting <= 1;
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE:  next_state = data ? S1   : IDLE;
            S1:    next_state = data ? S11  : IDLE;
            S11:   next_state = data ? S11  : S110;
            S110:  next_state = data ? S1101: IDLE;
            S1101: next_state = S1101; // Loop in final state; start_shifting remains 1
            default: next_state = IDLE;
        endcase
    end
endmodule
