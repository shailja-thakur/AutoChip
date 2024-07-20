module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition logic (sequential)
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end
    
    // Next state logic (combinational)
    always_comb begin
        case (current_state)
            STATE_A: 
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            STATE_B: 
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            default: 
                next_state = STATE_B; // Default state on reset or undefined current state
        endcase
    end
    
    // Output logic (combinational)
    always_comb begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1; // Output for undefined state
        endcase
    end

endmodule
