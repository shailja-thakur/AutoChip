module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Define the combinational always block for next state logic
    always @(*) begin
        case (state)
            A: begin
                if (j) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                if (k) 
                    next_state = A;
                else 
                    next_state = B;
            end
            default: next_state = A;  // Default case for safety
        endcase
    end

    // Sequential always block for state update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // Reset to state A
        else
            state <= next_state;  // Update to next state
    end

    // Output logic
    always @(state) begin
        out = (state == B);
    end

endmodule
