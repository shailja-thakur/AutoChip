module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;       // Set state to A on reset
        else 
            state <= next_state;  // Move to next state on clock edge
    end

    // Next state logic
    always_comb begin
        case (state)
            A: if (j) 
                   next_state = B;
               else 
                   next_state = A;
            B: if (k) 
                   next_state = A;
               else 
                   next_state = B;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

endmodule
