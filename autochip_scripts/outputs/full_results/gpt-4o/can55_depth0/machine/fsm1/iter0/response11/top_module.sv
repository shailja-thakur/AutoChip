module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    
    // State Definitions
    typedef enum reg {STATE_A, STATE_B} state_t;
    
    // State register
    reg state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: 
                next_state = in ? STATE_A : STATE_B;
            STATE_B: 
                next_state = in ? STATE_B : STATE_A;
            default: 
                next_state = STATE_B; // Default to State B for safety
        endcase
    end
    
    // State register update logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B; // Reset to State B
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        if (state == STATE_B)
            out = 1'b1;
        else
            out = 1'b0;
    end
    
endmodule
