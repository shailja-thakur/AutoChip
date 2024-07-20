module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State definitions
    typedef enum logic {A, B} state_t;
    state_t current_state, next_state;
    
    // State transition logic
    always_comb begin
        case (current_state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;  // Safe default state
        endcase
    end
    
    // State update on clock edge
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= B;  // Reset state is B
        else
            current_state <= next_state;
    end
    
    // Output logic
    always_ff @(posedge clk) begin
        out <= (current_state == B);
    end

endmodule
