module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // Define the state encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset to state A
        else
            state <= next_state; // Update state to next state
    end
    
    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: if (in) next_state = B; else next_state = A;
            B: if (in) next_state = B; else next_state = C;
            C: if (in) next_state = D; else next_state = A;
            D: if (in) next_state = B; else next_state = C;
            default: next_state = A; // Default case to handle any unexpected state
        endcase
    end
    
    // Output logic
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
