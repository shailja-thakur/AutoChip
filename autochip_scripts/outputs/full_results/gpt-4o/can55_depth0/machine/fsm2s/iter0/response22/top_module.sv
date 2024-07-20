module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define the two states
    typedef enum logic [1:0] {STATE_A = 2'b00, STATE_B = 2'b01} state_t;
    state_t state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        case (state)
            STATE_A: if (j)
                        next_state = STATE_B;
                     else
                        next_state = STATE_A;
            STATE_B: if (k)
                        next_state = STATE_A;
                     else
                        next_state = STATE_B;
            default: next_state = STATE_A;
        endcase
    end
    
    // Output logic
    always_comb begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
