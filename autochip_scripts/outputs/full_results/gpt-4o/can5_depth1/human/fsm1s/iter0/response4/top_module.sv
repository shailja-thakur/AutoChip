module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition
    always @ (posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state;
    end

    // Next state logic
    always @ (*) begin
        case (state)
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = B; // default to state B in case of any unknown state
        endcase
    end

    // Output logic (output depends only on the current state)
    always @ (*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1; // default output value
        endcase
    end

endmodule
