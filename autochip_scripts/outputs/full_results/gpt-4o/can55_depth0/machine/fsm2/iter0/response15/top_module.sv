module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // State encoding
    typedef enum logic {A, B} state_t;
    
    // Internal variables
    state_t current_state, next_state;
    
    // Combinational block to determine the next state
    always @(*) begin
        case (current_state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A; // Safeguard against undefined states
        endcase
    end
    
    // Clocked always block to update the state
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // Output logic
    assign out = (current_state == B);
    
endmodule
