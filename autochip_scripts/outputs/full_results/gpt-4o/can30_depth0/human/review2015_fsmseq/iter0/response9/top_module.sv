module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum logic[2:0] {
        S_IDLE = 3'b000,
        S_1 = 3'b001,
        S_11 = 3'b010,
        S_110 = 3'b011,
        S_FOUND = 3'b100
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            start_shifting <= 1'b0;
        end else begin
            state <= next_state;
            if (state == S_FOUND)
                start_shifting <= 1'b1;
        end
    end

    always_comb begin
        case (state)
            S_IDLE: next_state = data ? S_1 : S_IDLE;
            S_1: next_state = data ? S_11 : S_IDLE;
            S_11: next_state = data ? S_11 : S_110;
            S_110: next_state = data ? S_FOUND : S_IDLE;
            S_FOUND: next_state = S_FOUND;
            default: next_state = S_IDLE;
        endcase
    end
endmodule
