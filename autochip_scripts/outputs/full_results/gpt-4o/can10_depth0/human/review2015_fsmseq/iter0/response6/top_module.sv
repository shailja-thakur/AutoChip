module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        S1      = 3'b001,
        S11     = 3'b010,
        S110    = 3'b011,
        FOUND   = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data)
                    next_state = S1;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            S11: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S110;
            end
            S110: begin
                if (data)
                    next_state = FOUND;
                else
                    next_state = IDLE;
            end
            FOUND: begin
                next_state = FOUND; // Remain in FOUND state once it is reached
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 0;
        else if (state == FOUND)
            start_shifting <= 1;
    end

endmodule
