module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State declaration
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    // State transition logic (next state logic)
    always @(*) begin
        case(state)
            OFF: next_state = (j) ? ON : OFF;
            ON: next_state = (k) ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // State register update (state flip-flop)
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
