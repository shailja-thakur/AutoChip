module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    typedef enum logic [2:0] {
        S_IDLE     = 3'b000,
        S_1        = 3'b001,
        S_11       = 3'b010,
        S_110      = 3'b011,
        S_1101     = 3'b100
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
        unique case (state)
            S_IDLE: if (data) next_state = S_1;
            S_1: if (data) next_state = S_11; else next_state = S_IDLE;
            S_11: if (data) next_state = S_11; else next_state = S_110;
            S_110: if (data) next_state = S_1101; else next_state = S_IDLE;
            S_1101: next_state = S_1101;
        endcase
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (state == S_1101)
            start_shifting <= 1'b1;
    end

endmodule
