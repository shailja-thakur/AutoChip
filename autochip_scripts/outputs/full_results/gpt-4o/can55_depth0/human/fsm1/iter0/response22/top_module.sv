module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // State encoding
    typedef enum reg {STATE_A, STATE_B} state_t;
    
    // Current state and next state variables
    state_t current_state, next_state;
    
    // Asynchronous reset logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_B; // Reset state to B
        else
            current_state <= next_state;
    end

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_B; // Default state should be B
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1; // Default output should be 1
        endcase
    end

endmodule
