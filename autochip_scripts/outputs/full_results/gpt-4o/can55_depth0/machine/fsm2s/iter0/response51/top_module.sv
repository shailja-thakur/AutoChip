module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;
 
    // State register
    state_t state, next_state;
 
    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;  // Set state to A on reset
        end else begin
            state <= next_state;  // Transition to next state
        end
    end
 
    // Next state logic
    always_comb begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;  // Fallback to A
        endcase
    end
 
    // Output based on state
    always_comb begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;  // Default output
        endcase
    end

endmodule
