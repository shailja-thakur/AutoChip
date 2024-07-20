module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Output logic based on the current state
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1; // Default to satisfy combinational logic completeness
        endcase
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            B: if (in) next_state = B;
               else next_state = A;
            A: if (in) next_state = A;
               else next_state = B;
            default: next_state = B; // Default to satisfy combinational logic completeness
        endcase
    end
    
    // State register with reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end
endmodule
