module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum logic [1:0] {
        S_A = 2'b00,
        S_B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            S_B: if (in)
                    next_state = S_B;
                else
                    next_state = S_A;
            S_A: if (in)
                    next_state = S_A;
                else
                    next_state = S_B;
            default: next_state = S_B; // default to reset state
        endcase
    end
    
    // State register
    always @(posedge clk) begin
        if (reset)
            state <= S_B;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            S_B: out = 1;
            S_A: out = 0;
            default: out = 1; // default to reset state output
        endcase
    end
endmodule
