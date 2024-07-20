module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    // Define states
    typedef enum reg { A, B } state_t;
    state_t state, next_state;
    
    // Combinational always block to determine next state
    always @(*) begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;  // Default case to handle any unexpected inputs
        endcase
    end
    
    // Clocked always block to update the state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // Reset to state A
        else
            state <= next_state;
    end
    
    // Assign output based on the current state
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
