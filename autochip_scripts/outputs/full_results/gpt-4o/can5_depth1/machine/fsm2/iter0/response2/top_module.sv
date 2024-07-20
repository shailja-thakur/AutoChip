module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    // State encoding
    typedef enum logic [1:0] {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;

    // Combinational block to determine next state
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
            
            default: next_state = A; // Default to state A
        endcase
    end

    // Clocked always block to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset state to A
        else
            state <= next_state; // Update state to next state
    end

    // Output logic
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
