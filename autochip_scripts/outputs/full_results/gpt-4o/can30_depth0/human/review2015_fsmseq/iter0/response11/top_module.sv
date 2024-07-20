module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // Define states of the FSM
    typedef enum reg [2:0] {
        S_IDLE = 3'd0,
        S_1 = 3'd1,
        S_11 = 3'd2,
        S_110 = 3'd3,
        S_1101 = 3'd4
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S_IDLE: next_state = (data) ? S_1 : S_IDLE;
            S_1: next_state = (data) ? S_11 : S_IDLE;
            S_11: next_state = (data) ? S_11 : S_110; 
            S_110: next_state = (data) ? S_1101 : S_IDLE;
            S_1101: next_state = S_1101;
            default: next_state = S_IDLE;
        endcase
    end

    // State register logic (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            if (state == S_1101) 
                start_shifting <= 1;
        end
    end

endmodule
