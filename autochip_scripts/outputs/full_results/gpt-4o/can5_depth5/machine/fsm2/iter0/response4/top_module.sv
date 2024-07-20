module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    // Define states
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;
    
    // State registers
    state_t state, next_state;

    // Combinational block to determine next state
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A; // Default state for safety
        endcase
    end
    
    // Clocked block to update current state
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A; // Reset state to A
        else 
            state <= next_state;
    end
    
    // Output logic
    assign out = (state == B);

endmodule
