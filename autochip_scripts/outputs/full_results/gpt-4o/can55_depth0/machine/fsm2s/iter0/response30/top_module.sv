module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define states
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;
    
    // State variable
    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A; // Initialize state to A on reset
        end else begin
            state <= next_state; // Transition to next state
        end
    end

    // Next state logic
    always_comb begin
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
        endcase
    end

    // Output logic
    always_comb begin
        out = (state == B);
    end
endmodule
