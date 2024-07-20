module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg { A, B } state_t;
    state_t state, next_state;

    // State transitions
    always @(*) begin
        case (state)
            A: if (in) 
                   next_state = A;
               else 
                   next_state = B;
            B: if (in) 
                   next_state = B;
               else 
                   next_state = A;
            default: next_state = B; // Default to state B
        endcase
    end

    // State update on clock or reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // Reset state to B
        else
            state <= next_state; // Update state
    end

    // Output logic
    always @(state) begin
        if (state == B)
            out = 1;
        else
            out = 0;
    end

endmodule
