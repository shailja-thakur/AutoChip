module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    // State declarations
    typedef enum logic {
        A = 1'b0,
        B = 1'b1
    } state_t;
    
    state_t current_state, next_state;
    
    // Combinational block to determine the next state
    always_comb begin
        case (current_state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;
        endcase
    end
    
    // Clocked block to update the state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // Output logic
    assign out = (current_state == B);

endmodule
