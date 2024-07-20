module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the state encoding
    typedef enum reg {B, A} state_t;
    state_t state, next_state;
    
    // Synchronous state transition with reset
    always @(posedge clk) begin
        if (reset) 
            state <= B;  // Reset state
        else 
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            B: begin
                out = 1;  // Output when in state B
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            A: begin
                out = 0;  // Output when in state A
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
        endcase
    end

endmodule
