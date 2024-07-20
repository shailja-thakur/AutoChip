module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: if (j) next_state = ON; else next_state = OFF;
            ON: if (k) next_state = OFF; else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic (Moore state machine output depends only on state)
    always @(*) begin
        case (state)
            OFF: out = 0;
            ON: out = 1;
            default: out = 0;
        endcase
    end

endmodule
