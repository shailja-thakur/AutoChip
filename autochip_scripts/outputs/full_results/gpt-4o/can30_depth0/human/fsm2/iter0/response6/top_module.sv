module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    // State transition

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k == 1)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF; // Default case to handle unexpected states
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            OFF: out = 0;
            ON: out = 1;
            default: out = 0; // Default case to handle unexpected states
        endcase
    end

endmodule
