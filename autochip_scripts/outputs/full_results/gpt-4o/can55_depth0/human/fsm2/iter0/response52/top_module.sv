module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    typedef enum reg {OFF = 1'b0, ON = 1'b1} state_t;
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            OFF: next_state = (j) ? ON : OFF;
            ON: next_state = (k) ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic (outputs based on state)
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
